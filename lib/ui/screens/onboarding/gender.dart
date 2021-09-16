import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/genders_container.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class OnboardingGenderScreen extends StatefulWidget {
  const OnboardingGenderScreen({Key? key}) : super(key: key);

  @override
  _OnboardingGenderScreenState createState() => _OnboardingGenderScreenState();
}

class _OnboardingGenderScreenState extends State<OnboardingGenderScreen> {
  Gender? activeButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SkipButton(
                onPressed: () {
                  // TODO: Store data (https://cesko-digital.atlassian.net/browse/LOON-144)
                  Navigator.pushNamed(context, '/create-account');
                },
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.gender_title,
                  style: const TextStyle(
                    color: LoonoColors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(child: GendersContainer(
                genderCallBack: (gender) {
                  setState(() {
                    activeButton = gender;
                  });
                },
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LoonoButton(
                  text: context.l10n.continue_info,
                  enabled: activeButton != null,
                  onTap: activeButton == null
                      ? () {}
                      : () {
                          // TODO: Store data (https://cesko-digital.atlassian.net/browse/LOON-144)
                          Navigator.pushNamed(context, '/onboarding/birthdate');
                        },
                ),
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
