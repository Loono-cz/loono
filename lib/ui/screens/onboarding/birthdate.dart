import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

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
                  child: CustomDatePicker(
                    callback: (DateTime selectedDate) {
                      // TODO: Handle selected date
                      print(selectedDate);
                    },
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
