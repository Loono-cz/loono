import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';

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
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 4),
                SvgPicture.asset(
                  itemPath,
                  width: MediaQuery.of(context).size.width / 3,
                ),
                const SizedBox(height: 24),
                SvgPicture.asset('assets/icons/item-shadow.svg'),
                const SizedBox(height: 24),
                Text(
                  context.l10n.achievement_subtitle_earning,
                  textAlign: TextAlign.center,
                  style: LoonoFonts.paragraphFontStyle,
                ),
                const SizedBox(height: 8),
                Text(header, textAlign: TextAlign.center, style: LoonoFonts.bigFontStyle),
                const SizedBox(height: 12),
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LoonoPointIcon(),
                    const SizedBox(width: 8),
                    Text(
                      numberOfPoints.toString(),
                      style: LoonoFonts.subtitleFontStyle.copyWith(
                        color: LoonoColors.primaryEnabled,
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
                LoonoButton(text: context.l10n.continue_info, onTap: onButtonTap),
                SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
