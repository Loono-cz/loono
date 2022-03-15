import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/avatar_arrow_bubble.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/ui/widgets/prevention/profile_button.dart';

class PreventionScreen extends StatelessWidget {
  PreventionScreen({Key? key}) : super(key: key);

  final ValueNotifier<double?> extentFromTop = ValueNotifier<double?>(null);

  void convertExtent(double? extent) {
    Future.delayed(Duration.zero, () async {
      extentFromTop.value = extent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                const BadgeComposer(),
                ValueListenableBuilder(
                  valueListenable: extentFromTop,
                  builder: (context, double? value, child) {
                    if (value != null) {
                      return AvatarBubbleArrow(
                        extent: value,
                        height: constraints.maxHeight,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                ExaminationsSheetOverlay(
                  convertExtent: convertExtent,
                ),
                const ProfileButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
