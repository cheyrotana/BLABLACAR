import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// A reusable stateless widget for form rows in the ride preference form.
class RidePrefFormRow extends StatelessWidget {
  final String? label;
  final String? value;
  final VoidCallback onTap;
  final IconData formIcon;
  final Widget? trailing;

  const RidePrefFormRow({
    super.key,
    this.label,
    this.value,
    required this.onTap,
    required this.formIcon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final String displayText = value ?? label ?? '';
    final bool isPlaceholder = value == null && label != null;

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
