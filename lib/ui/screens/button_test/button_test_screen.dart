import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/actions/bla_button.dart';

/// A test screen to demonstrate and verify all BlaButton variants.
/// Includes primary/secondary, enabled/disabled, and with/without icons.
class ButtonTestScreen extends StatelessWidget {
  const ButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Test Screen'),
        backgroundColor: BlaColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Primary Buttons', style: BlaTextStyles.heading),
            const SizedBox(height: BlaSpacings.m),
            BlaButton(
              buttonText: 'Primary Enabled',
              isPrimary: true,
              onPressed: () => debugPrint('Primary Enabled Pressed'),
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Primary Disabled',
              isPrimary: true,
              onPressed: null,
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Primary with Icon',
              buttonIcon: Icons.add,
              isPrimary: true,
              onPressed: () => debugPrint('Primary with Icon Pressed'),
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Primary Disabled with Icon',
              buttonIcon: Icons.add,
              isPrimary: true,
              onPressed: null,
            ),
            const SizedBox(height: BlaSpacings.l),
             Text('Secondary Buttons', style: BlaTextStyles.heading),
            const SizedBox(height: BlaSpacings.m),
            BlaButton(
              buttonText: 'Secondary Enabled',
              isPrimary: false,
              onPressed: () => debugPrint('Secondary Enabled Pressed'),
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Secondary Disabled',
              isPrimary: false,
              onPressed: null,
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Secondary with Icon',
              buttonIcon: Icons.edit,
              isPrimary: false,
              onPressed: () => debugPrint('Secondary with Icon Pressed'),
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              buttonText: 'Secondary Disabled with Icon',
              buttonIcon: Icons.edit,
              isPrimary: false,
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
