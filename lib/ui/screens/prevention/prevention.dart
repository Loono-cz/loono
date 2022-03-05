import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/avatar_arrow_bubble.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/ui/widgets/prevention/profile_button.dart';

class PreventionScreen extends StatefulWidget {
  const PreventionScreen({Key? key}) : super(key: key);

  @override
  State<PreventionScreen> createState() => _PreventionScreenState();
}

class _PreventionScreenState extends State<PreventionScreen> {
  double? extentFromTop;

  void convertExtent(double? extent) {
    setState(() {
      extentFromTop = extent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (extentFromTop != null)
              AvatarBubbleArrow(
                extent: extentFromTop!,
              ),
            const ProfileButton(),
            const BadgeComposer(),
            ExaminationsSheetOverlay(
              convertExtent: convertExtent,
            ),
          ],
        ),
      ),
    );
  }
}
