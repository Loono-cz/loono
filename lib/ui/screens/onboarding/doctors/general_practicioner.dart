import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';

class OnboardingGeneralPracticionerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: const UniversalDoctorScreen(
            questionHeader: "Praktického lékaře?",
            imagePath: "practicioner",
            numberOfSteps: 3,
            currentStep: 1,
            nextScreen1: "/general-practicioner-achievement",
            nextScreen2: "/onboarding/doctor/general-practitioner-date",
            skipScreen: "/onboarding/doctor/gynecology",
          )
      ),
    );
  }
}