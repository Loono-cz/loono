import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// Shared components / finders across multiple screens.
///
class CommonSharedFinders {
  static final Finder onboardingSkipQuestionnaireBtn =
      find.widgetWithText(TextButton, 'Přeskočit dotazník');

  static final Finder settingsSheetBackBtn = find.byKey(const Key('settings_sheet_backButton'));
  static final Finder settingsSheetCloseBtn = find.byKey(const Key('settings_sheet_closeButton'));
}
