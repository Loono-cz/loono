import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// Shared components / finders across multiple screens.
///
class CommonSharedFinders {
  static final Finder onboardingSkipQuestionnaireBtn =
      find.widgetWithText(TextButton, 'Přeskočit dotazník');
}
