import 'package:flutter/material.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

class PreventionScreen extends StatefulWidget {
  const PreventionScreen({Key? key}) : super(key: key);

  @override
  State<PreventionScreen> createState() => _PreventionScreenState();
}

class _PreventionScreenState extends State<PreventionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () => showSettingsSheet(context),
                child: const Text('SETTINGS'),
              ),
            ),
            const BadgeComposer(),
            const ExaminationsSheetOverlay(),
          ],
        ),
      ),
    );
  }
}
