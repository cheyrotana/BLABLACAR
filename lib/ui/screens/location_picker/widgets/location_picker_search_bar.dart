import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

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
      child: TextFormField(
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
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
