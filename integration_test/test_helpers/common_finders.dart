import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/custom_navigation_bar.dart';
import 'package:loono_api/loono_api.dart';

///
/// Common finders shared across multiple screens.
///

mixin OnboardingFinders {
  @protected
  final Finder commonOnboardingSkipQuestionnaireBtn =
      find.widgetWithText(TextButton, 'Přeskočit dotazník');
}

mixin SettingsFinders {
  @protected
  final Finder commonSettingsSheetBackBtn = find.byKey(const Key('settings_sheet_backButton'));

  @protected
  final Finder commonSettingsSheetCloseBtn = find.byKey(const Key('settings_sheet_closeButton'));
}

mixin MainScreenFinders {
  @protected
  final Finder commonPreventionBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('Prevence'),
  );

  @protected
  final Finder commonFindDoctorBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('Najít lékaře'),
  );

  @protected
  final Finder commonAboutHealthBottomNavItem = find.descendant(
    of: find.byType(CustomNavigationBar),
    matching: find.text('O zdraví'),
  );
}

mixin BadgeFinders {
  @protected
  Finder commonGetBadge(BadgeType type) =>
      find.byKey(ValueKey<String>('badgeComposer_${type.name}'), skipOffstage: false);
}
