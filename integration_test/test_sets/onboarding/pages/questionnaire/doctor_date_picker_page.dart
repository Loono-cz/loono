import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practitioner_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen is either:
/// [GeneralPractitionerDateScreen], [GynecologyDateScreen] or [DentistDateScreen].
class QuestionnaireDoctorDatePickerPage with OnboardingFinders {
  QuestionnaireDoctorDatePickerPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder idkBtn = find.widgetWithText(TextButton, 'Nevím');
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueButton() async {
    logTestEvent();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickIdkButton() async {
    logTestEvent();
    await tester.tap(idkBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown({required Type expectedScreen}) async {
    final screen = find.byType(expectedScreen);
    await tester.pumpUntilFound(screen);
    logTestEvent('Verify screen is shown: "${tester.widget(screen).runtimeType}"');
  }
}
