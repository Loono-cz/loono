import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({
    required this.header,
    required this.textLines,
    required this.numberOfPoints,
    required this.nextScreen,
  });

  final String header;
  final List<String> textLines;
  final int numberOfPoints;
  final String nextScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              SvgPicture.asset(
                'assets/icons/guarantee.svg',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 18),
              Text(header, textAlign: TextAlign.center, style: LoonoFonts.headerFontStyle),
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
                  SvgPicture.asset('assets/icons/star.svg', color: LoonoColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    numberOfPoints.toString(),
                    style: LoonoFonts.subtitleFontStyle.copyWith(color: LoonoColors.primary),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              LoonoButton(
                text: context.l10n.continue_info,
                onTap: () => Navigator.pushNamed(context, nextScreen),
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
