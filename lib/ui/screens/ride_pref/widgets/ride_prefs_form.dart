import 'package:blabla/ui/screens/location_picker/location_picker_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
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
  bool swapButtonOnDeparture =
      true; // true: swap button on departure row; false: on arrival row

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      // No initial RidePref, set defaults
      departureDate = DateTime.now(); // Defaults to now
      requestedSeats = 1; // Default: 1 seat
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  /// Handles the selection of departure location by navigating to the picker screen.
  void _selectDeparture() async {
    // 1 - Push the departure selection screen
    final departureResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    // 2 - Check result and update state if valid
    if (departureResult != null && departureResult is Location) {
      setState(() {
        departure = departureResult;
      });
    }
  }

  /// Handles the selection of arrival location by navigating to the picker screen.
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

  /// Handles the selection of departure date by navigating to the date picker screen.
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

  /// Handles the selection of number of seats by navigating to the seats picker screen.
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

  /// Swaps the departure and arrival locations, and toggles the swap button position.
  void _swapLocations() {
    setState(() {
      // 1 - Swap the locations
      final Location temp = departure!;
      departure = arrival;
      arrival = temp;
      // 2 - Toggle the button position
      swapButtonOnDeparture = !swapButtonOnDeparture;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel => 'Leaving from';
  String? get departureValue => departure?.name;
  String get arrivalLabel => 'Going to';
  String? get arrivalValue => arrival?.name;
  String get dateText {
    return DateTimeUtils.formatDateTime(departureDate);
  }

  String get seatsText => '$requestedSeats';

  /// Builds the swap button widget for swapping locations.
  Widget? _swapButton() {
    return SizedBox(
      width: BlaSpacings.l,
      height: BlaSpacings.l,
      child: IconButton(
        icon: const Icon(Icons.swap_vert),
        onPressed: _swapLocations,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        color: BlaColors.primary,
      ),
    );
  }

  /// Returns the trailing widget for the departure row
  Widget? _departureTrailing() {
    if (swapButtonOnDeparture && departure != null) return _swapButton();
    return null;
  }

  /// Returns the trailing widget for the arrival row
  Widget? _arrivalTrailing() {
    if (!swapButtonOnDeparture && arrival != null) return _swapButton();
    return null;
  }

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
          label: departureLabel,
          value: departureValue,
          onTap: _selectDeparture,
          formIcon: Icons.circle_outlined,
          trailing: _departureTrailing(),
        ),
        BlaDivider(),
        _formRow(
          label: arrivalLabel,
          value: arrivalValue,
          onTap: _selectArrival,
          formIcon: Icons.circle_outlined,
          trailing: _arrivalTrailing(),
        ),
        BlaDivider(),
        _formRow(
          value: dateText,
          onTap: _selectDate,
          formIcon: Icons.calendar_month_rounded,
        ),
        BlaDivider(),
        _formRow(
          value: seatsText,
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
    String? label,
    String? value,
    required VoidCallback onTap,
    required IconData formIcon,
    Widget? trailing,
  }) {
    // Determine the text to display
    final String displayText = value ?? label ?? '';

    // Determine if the displayed text is a placeholder
    final bool isPlaceholder;
    if (value == null && label != null) {
      isPlaceholder = true;
    } else {
      isPlaceholder = false;
    }

    return ListTile(
      contentPadding: EdgeInsets.all(BlaSpacings.s),
      leading: Icon(formIcon),
      title: Text(
        displayText,
        style: BlaTextStyles.body.copyWith(
          color: isPlaceholder ? BlaColors.neutralLight : null,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
