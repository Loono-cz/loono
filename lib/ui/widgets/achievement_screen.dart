import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/space.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({
    Key? key,
    required this.header,
    required this.textLines,
    required this.numberOfPoints,
    required this.itemPath,
    required this.onButtonTap,
  }) : super(key: key);

  final String header;
  final List<String> textLines;
  final int numberOfPoints;
  final String itemPath;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: context.mediaQuery.compactSizeOf(18),
              left: context.mediaQuery.compactSizeOf(18),
              right: context.mediaQuery.compactSizeOf(18),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            itemPath,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          const Space.vertical(24),
                          SvgPicture.asset(LoonoAssets.itemShadow),
                          const Space.vertical(24),
                          Text(
                            context.l10n.achievement_subtitle_earning,
                            textAlign: TextAlign.center,
                            style: LoonoFonts.paragraphFontStyle,
                          ),
                          const Space.vertical(8),
                          Text(
                            header,
                            textAlign: TextAlign.center,
                            style: LoonoFonts.bigFontStyle,
                          ),
                          const Space.vertical(12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: textLines
                                  .map(
                                    (textLine) => Text(
                                      textLine,
                                      textAlign: TextAlign.center,
                                      style: LoonoFonts.paragraphFontStyle,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const Space.vertical(24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LoonoPointIcon(),
                              const Space.horizontal(8),
                              Text(
                                numberOfPoints.toString(),
                                style: LoonoFonts.subtitleFontStyle.copyWith(
                                  color: LoonoColors.primaryEnabled,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Space.vertical(70),
                LoonoButton(
                  text: context.l10n.continue_info,
                  onTap: onButtonTap,
                ),
                Space.vertical(LoonoSizes.buttonBottomPadding(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
