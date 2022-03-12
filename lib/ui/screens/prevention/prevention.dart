import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/avatar_arrow_bubble.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/ui/widgets/prevention/profile_button.dart';

class PreventionScreen extends StatelessWidget {
  PreventionScreen({Key? key}) : super(key: key);

  final ValueNotifier<double?> extentFromTop = ValueNotifier<double?>(null);

  void convertExtent(double? extent) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => extentFromTop.value = extent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: extentFromTop,
              builder: (context, double? value, child) {
                if (value != null) {
                  return AvatarBubbleArrow(
                    extent: value,
                  );
                }
                return const SizedBox();
              },
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
