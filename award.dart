import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AwardScreen extends StatelessWidget {
  final String imagePath = 'assets/icons/guarantee.svg';

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
              const Text("Gratulujeme!"),
              const Text(
                  "Pravidelná prohlídka ti dodá klid. A taky máš velkou šanci odhalit závažná onemocnění včas."),
              const Text('Jen tak dál…'),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/star.svg",
                  ),
                  const SizedBox(width: 4),
                  const Text("200"),
                ],
              ),
              const SizedBox(height: 64),
              LoonoButton(() => {Navigator.pushNamed(context, '/onboarding/doctor/gynecology')}, AppLocalizations.of(context)!.continue_info,
                  enabled: true),
            ],
          ),
        ),
      ),
    );
  }
}
