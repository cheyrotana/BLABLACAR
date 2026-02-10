import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// BlaButton is a custom button widget used throughout the app.
/// It supports primary and secondary styles, with optional icons.
/// - Primary buttons use a filled style with the primary color.
/// - Secondary buttons use a filled style with a border.
/// - Icons can be added optionally.
/// - Width can be customized; defaults to full width if not specified.
class BlaButton extends StatelessWidget {
  final String buttonText;
  final IconData? buttonIcon;
  final bool isPrimary;
  final VoidCallback onPressed;
  final double? width;

  const BlaButton({
    super.key,
    required this.buttonText,
    this.buttonIcon,
    required this.isPrimary,
    required this.onPressed,
    this.width,
  });

  // Compute colors and border based on primary status
  Color get buttonColor =>
      isPrimary ? BlaColors.backGroundColor : BlaColors.white;
  Color get textColor =>
      isPrimary ? BlaColors.white : BlaColors.backGroundColor;
  Color get iconColor => textColor;
  BorderSide? get borderSide =>
      isPrimary ? null : BorderSide(color: BlaColors.greyLight);

  @override
  Widget build(BuildContext context) {
    // Build the button child with optional icon
    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (buttonIcon != null) // Include icon if provided
          Icon(buttonIcon, color: iconColor),
        if (buttonIcon != null)
          SizedBox(width: BlaSpacings.s), // Add spacing if icon exists
        Flexible(
          child: Text(
            buttonText,
            style: BlaTextStyles.button.copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    // Create the button with conditional styling
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          side: borderSide,
          elevation: 0,
        ),
        child: buttonChild,
      ),
    );
  }
}
