import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/avatar_arrow_bubble.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';
import 'package:loono/ui/widgets/prevention/prevention_header.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

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
    final count = Provider.of<ExaminationsProvider>(context, listen: true)
            .examinations
            ?.examinations
            .where((item) => item.examinationCategoryType == ExaminationCategoryType.CUSTOM)
            .length ??
        0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: count >= 10
            ? null
            : () {
                AutoRouter.of(context).push(const CustomExamFormRoute());
              },
        backgroundColor: count >= 10 ? LoonoColors.grey : LoonoColors.primaryEnabled,
        child: const Icon(
          Icons.add,
          size: 36.0,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 60),
                  child: SvgPicture.asset(
                    'assets/icons/hero_background.svg',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.735,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: BadgeComposer(showDescription: false),
                ),
                IgnorePointer(
                  child: ValueListenableBuilder(
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
                ),
                ExaminationsSheetOverlay(
                  convertExtent: convertExtent,
                ),
                const PreventionHeader()
              ],
            );
          },
        ),
      ),
    );
  }
}
