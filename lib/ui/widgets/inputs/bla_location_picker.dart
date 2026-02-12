import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/location_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

/// This screen allows users to pick locations from a searchable list.
/// - Provides a search bar to filter locations by name
/// - Displays matching locations in a scrollable list
/// - Returns the selected location to the previous screen
class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  late TextEditingController searchController;
  List<Location> searchResults = [];

  @override
  void initState() {
    super.initState();
    // Initialize the text controller for the search bar
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      // 1 - Check if query is at least 2 characters long
      if (query.length >= 2) {
        // 2 - Filter available locations that starts with the query (case insensitive)
        searchResults = LocationsService.availableLocations
            .where(
              (availableLocation) => availableLocation.name
                  .toLowerCase()
                  .startsWith(query.toLowerCase()),
            )
            .toList();
      } else {
        // 3 - Clear search results if query is too short
        searchResults = [];
      }
    });
  }

  void _onLocationSelected(Location location) {
    // Return the selected location to the previous screen
    Navigator.pop(context, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m,
            right: BlaSpacings.m,
          ),
          child: Column(
            children: [
              LocationPickerSearchBar(
                controller: searchController,
                onSearchChanged: _onSearchChanged,
                onBackPressed: () => Navigator.pop(context),
                onClearPressed: () {
                  searchController.clear();
                  _onSearchChanged('');
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return LocationListTile(
                      cityName: searchResults[index].name,
                      countryName: searchResults[index].country.name,
                      onPressed: () =>
                          _onLocationSelected(searchResults[index]),
                    );
                  },
                  separatorBuilder: (context, index) => BlaDivider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This widget provides a search bar for the location picker.
/// - Displays a text field for entering search queries
/// - Includes a back button to navigate back
/// - Shows a clear button when text is entered
/// - Calls callbacks for search changes, back press, and clear press
class LocationPickerSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onBackPressed;
  final VoidCallback onClearPressed;

  const LocationPickerSearchBar({
    super.key,
    required this.controller,
    required this.onSearchChanged,
    required this.onBackPressed,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: TextField(
        controller: controller,
        onChanged: onSearchChanged,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: onBackPressed,
            icon: Icon(Icons.arrow_back_ios, size: 16),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(onPressed: onClearPressed, icon: Icon(Icons.clear))
              : null,
          hintText: 'Station Road or The Bridge Cafe',
          hintStyle: BlaTextStyles.label,
          contentPadding: EdgeInsets.all(BlaSpacings.m),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: BlaColors.greyLight,
        ),
      ),
    );
  }
}

/// This widget displays a location result in the location picker list.
/// - Shows the city name as the title
/// - Shows the country name as subtitle
/// - Includes an arrow icon for navigation
/// - Handles tap to select the location
class LocationListTile extends StatelessWidget {
  final String cityName;
  final String countryName;
  final VoidCallback onPressed;

  const LocationListTile({
    super.key,
    required this.cityName,
    required this.countryName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        title: Text(cityName, style: BlaTextStyles.body),
        subtitle: Text(countryName, style: BlaTextStyles.label),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
