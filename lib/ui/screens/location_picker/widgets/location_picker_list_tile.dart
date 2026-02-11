import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

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
