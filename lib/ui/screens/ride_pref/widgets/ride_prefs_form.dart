import 'package:blabla/ui/screens/location_picker/location_picker_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/date_time_utils.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure =
          widget.initRidePref!.departure; // Departure location from init
      arrival = widget.initRidePref!.arrival; // Arrival location from init
      departureDate =
          widget.initRidePref!.departureDate; // Departure date from init
      requestedSeats =
          widget.initRidePref!.requestedSeats; // Number of seats from init
    } else {
      // No initial RidePref, set defaults
      departureDate = DateTime.now(); // Defaults to now
      requestedSeats = 1; // Default: 1 seat
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void _selectDeparture() async {
    // 1 - Push the departure selection screen
    final departureResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationPickerScreen()),
    );

    // 2 - Check result and update state if valid
    if (departureResult != null && departureResult is Location) {
      setState(() {
        departure = departureResult;
      });
    }
  }

  void _selectArrival() async {
    // 1 - Push the arrival selection screen
    final arrivalLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    // 2 - Check result and update state if valid
    if (arrivalLocation != null && arrivalLocation is Location) {
      setState(() {
        arrival = arrivalLocation;
      });
    }
  }

  void _selectDate() async {
    // 1 - Push the date selection screen
    final departureDateResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Placeholder()),
    );

    // 2 - Check result and update state if valid
    if (departureDateResult != null && departureDateResult is DateTime) {
      setState(() {
        departureDate = departureDateResult;
      });
    }
  }

  void _selectSeats() async {
    // 1 - Push the seats selection screen
    final requestedSeatResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Placeholder()),
    );

    // 2 - Check result and update state if valid
    if (requestedSeatResult != null && requestedSeatResult is int) {
      setState(() {
        requestedSeats = requestedSeatResult;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureText => departure?.name ?? 'Select departure';
  String get arrivalText => arrival?.name ?? 'Select arrival';
  String get dateText => DateTimeUtils.formatDateTime(departureDate);
  String get seatsText => '$requestedSeats';

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _formRow(
          formText: departureText,
          onTap: _selectDeparture,
          formIcon: Icons.circle_outlined,
          formBottomBorder: BorderSide(color: BlaColors.greyLight),
        ),
        _formRow(
          formText: arrivalText,
          onTap: _selectArrival,
          formIcon: Icons.circle_outlined,
          formBottomBorder: BorderSide(color: BlaColors.greyLight),
        ),
        _formRow(
          formText: dateText,
          onTap: _selectDate,
          formIcon: Icons.calendar_month_rounded,
          formBottomBorder: BorderSide(color: BlaColors.greyLight),
        ),
        _formRow(
          formText: seatsText,
          onTap: _selectSeats,
          formIcon: Icons.person_outline,
        ),
        SizedBox(
          child: BlaButton(
            buttonText: 'Search',
            isPrimary: true,
            onPressed: () => {},
          ),
        ),
      ],
    );
  }

  /// Builds a reusable row widget for form fields
  Widget _formRow({
    required String
    formText, // The text to display in the row (e.g., location name or date)
    required VoidCallback onTap, // Callback when the row is tapped
    BorderSide? formBottomBorder, // Optional bottom border for styling
    required IconData formIcon, // Icon to display at the start of the row
  }) {
    return GestureDetector(
      onTap: onTap, 
      child: Padding(
        padding: EdgeInsets.all(
          BlaSpacings.m,
        ), 
        child: Container(
          decoration: formBottomBorder != null
              ? BoxDecoration(
                  border: Border(bottom: formBottomBorder),
                ) 
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: BlaSpacings.s, 
              vertical: BlaSpacings.s, 
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, 
              children: [
                Icon(formIcon),
                SizedBox(
                  width: BlaSpacings.s,
                ),
                Expanded(
                  child: Text(
                    formText, 
                    style: BlaTextStyles.body, 
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
