import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// Common finders shared across multiple screens.
///

mixin OnboardingFinders {
  @protected
  Finder commonOnboardingSkipQuestionnaireBtn =
      find.widgetWithText(TextButton, 'Přeskočit dotazník');
}

mixin SettingsFinders {
  @protected
  Finder commonSettingsSheetBackBtn = find.byKey(const Key('settings_sheet_backButton'));

  @protected
  Finder commonSettingsSheetCloseBtn = find.byKey(const Key('settings_sheet_closeButton'));
}
