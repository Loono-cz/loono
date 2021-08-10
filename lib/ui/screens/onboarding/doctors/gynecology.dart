import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/universal_doctor_screen.dart';

class OnboardingGynecologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: const UniversalDoctorScreen(
            questionHeader: "Gynekologii?",
            imagePath: "gynecology",
            numberOfSteps: 3,
            currentStep: 2,
            nextScreen: "/achievement",
            skipScreen: "'/create-account'",
          )
      ),
    );
  }
}

