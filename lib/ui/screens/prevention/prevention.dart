import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/ui/widgets/prevention/profile_button.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const [
            ProfileButton(),
            BadgeComposer(),
            ExaminationsSheetOverlay(),
          ],
        ),
      ),
    );
  }
}
