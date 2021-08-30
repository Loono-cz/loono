import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/ui/widgets/button.dart';

class AchievementScreen extends StatelessWidget {
  final String textUpper;
  final String textMiddle;
  final String textLower;
  final int numberOfPoints;
  final String nextScreen;
  const AchievementScreen({
    required this.textUpper,
    required this.textLower,
    required this.textMiddle,
    required this.numberOfPoints,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/guarantee.svg'),
              const SizedBox(height: 32),
              Text(textUpper),
              Text(textMiddle),
              Text(textLower),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/star.svg",
                  ),
                  const SizedBox(width: 4),
                  Text(numberOfPoints.toString()),
                ],
              ),
              const SizedBox(height: 64),
              LoonoButton(() => {Navigator.pushNamed(context, nextScreen)}, AppLocalizations.of(context)!.continue_info,
                  enabled: true),
            ],
          ),
        ),
      ),
    );
  }
}
