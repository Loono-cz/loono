import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class OnBoardingBirthdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SkipButton(onPressed: () => Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner')),
              const SizedBox(
                height: 70,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kdy ses narodil/a?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CustomDatePicker(
                      valueChanged: (selectedDate) {
                        // TODO: Handle selected date
                        print(selectedDate);
                      },
                    ),
                  ),
                ),
              ),
              ExtendedInkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner');
                },
                materialColor: const Color(0xFFEFAD89),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: const SizedBox(
                  height: 65,
                  child: Align(
                    child: Text('Pokračovat', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
