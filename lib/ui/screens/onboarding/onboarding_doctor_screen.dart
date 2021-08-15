import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/progress_dots.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/universal_doctor_widget.dart';

class OnboardingDoctorScreen extends StatelessWidget {
  const OnboardingDoctorScreen({required this.doctorType});

  final DoctorType doctorType;

  @override
  Widget build(BuildContext context) {
    int _currentStep = 0;
    String _skipScreen = "";
    String _docWidgetScreen = "";

    switch (doctorType) {
      case DoctorType.practitioner:
        _currentStep = 1;
        _skipScreen = '/onboarding/doctor/gynecology';
        _docWidgetScreen = '/onboarding/doctor/gynecology';
        break;
      case DoctorType.gynecologist:
        _currentStep = 2;
        _skipScreen = '/onboarding/doctor/dentist';
        _docWidgetScreen = '/onboarding/doctor/dentist';
        break;
      case DoctorType.dentist:
        _currentStep = 3;
        _skipScreen = '/achievement';
        _docWidgetScreen = '/achievement';
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkipButton(
                onPressed: () => Navigator.pushNamed(context, _skipScreen),
                sibling: LoonoProgressIndicator(
                  numberOfSteps: 3,
                  currentStep: _currentStep,
                ),
              ),
              Expanded(
                child: UniversalDoctor(
                  forDoctorType: doctorType,
                  nextCallback: () {
                    Navigator.pushNamed(context, _docWidgetScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
