import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding_second.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';
import 'package:loono/ui/widgets/onboarding/genders_container.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
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
                  Navigator.pop(context); //TODO jump na posledni stranku
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OnBoardingPageSecond()),
                          );
                        },
                  splashColor: activeButton == null ? Colors.transparent : null,
                  materialColor: activeButton == null
                      ? const Color(0xFFEFAD89).withOpacity(0.5)
                      : const Color(0xFFEFAD89),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: const SizedBox(
                    height: 65,
                    child: Align(
                      child: Text('Pokračovat',
                          style: TextStyle(color: Colors.white)),
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
