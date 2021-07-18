import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding_second.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';
import 'package:loono/ui/widgets/onboarding/genders_container.dart';

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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner');
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Přeskočit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Jaké je tvoje pohlaví?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
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
                child: ExtendedInkWell(
                  onTap: activeButton == null
                      ? () {}
                      : () {
                          Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner');
                        },
                  splashColor: activeButton == null ? Colors.transparent : null,
                  materialColor: activeButton == null
                      ? const Color(0xFFEFAD89).withOpacity(0.5)
                      : const Color(0xFFEFAD89),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: const SizedBox(
                    height: 65,
                    child: Align(
                      child: Text('Pokračovat', style: TextStyle(color: Colors.white)),
                    ),
                  ),
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
