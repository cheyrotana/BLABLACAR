import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/location_service.dart';
import 'package:blabla/ui/screens/location_picker/widgets/location_picker_list_tile.dart';
import 'package:blabla/ui/screens/location_picker/widgets/location_picker_search_bar.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

/// This screen allows users to pick locations from a searchable list.
/// - Provides a search bar to filter locations by name
/// - Displays matching locations in a scrollable list
/// - Returns the selected location to the previous screen
class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
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
        // 2 - Filter available locations that contain the query (case insensitive)
        searchResults = LocationsService.availableLocations
            .where(
              (availableLocation) => availableLocation.name
                  .toLowerCase()
                  .contains(query.toLowerCase()),
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
