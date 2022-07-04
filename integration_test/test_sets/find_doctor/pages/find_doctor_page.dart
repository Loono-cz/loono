import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/map_test_utils.dart';
import '../../../test_helpers/pom_class_helpers.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [FindDoctorScreen]
class FindDoctorPage extends MapTestUtils with PomClassHelpers {
  FindDoctorPage(WidgetTester tester) : super(tester);

  /// Page finders
  final Finder backButton = find.byType(BackButton);
  final Finder closeButton = find.byKey(const Key('findDoctorPage_closeButton'));

  final Finder mainSearchField = find.byKey(const Key('findDoctorPage_mainSearchField'));
  final Finder mainSearchFieldSpecClear =
      find.byKey(const Key('mainSearchTextField_specialization_clear'));

  final Finder loadingIndicator = find.byKey(const Key('findDoctorPage_loadingIndicator'));
  final Finder errorIndicator = find.byKey(const Key('findDoctorPage_errorIndicator'));

  final Finder noDoctorsAroundFlushbar =
      find.byKey(const Key('mapSheetOverlay_flushbar_noDoctorsAround'));
  final Finder doctorsSheet = find.byKey(const Key('mapSheetOverlay_sheet'));
  final Finder doctorsSheetList = find.byKey(const Key('mapSheetOverlay_list'));
  final Finder doctorsSheetHandle = find.byKey(const Key('mapSheetOverlay_handle'));

  final Finder doctorDetailSheet = find.byKey(const Key('findDoctorPage_doctorDetailSheet'));

  Finder getDoctorCardById(String id) => find.byKey(ValueKey<String>('mapSheetOverlay_card_$id'));

  /// Page methods
  Future<void> clickDoctorCardById(String id) async {
    logTestEvent('Click "Doctor card" with id: "$id"');
    final doctorCard = getDoctorCardById(id);
    await tester.ensureVisible(doctorCard);
    await tester.pumpAndSettle();
    await tester.tap(doctorCard);
    await tester.pumpAndSettle();
  }

  void verifyDoctorsCountInSheet({required int expectedCount}) {
    logTestEvent('Verify doctors count in sheet is: "$expectedCount"');
    final sliverList = tester.widget<SliverList>(doctorsSheetList);
    expect(
      (sliverList.delegate as SliverChildBuilderDelegate).childCount,
      expectedCount,
    );
  }

  VerifyVisibilityState get verifyDoctorDetailSheetVisibilityState =>
      getVerifyVisibilityStateFunction(
        finder: doctorDetailSheet,
        widgetName: 'Doctor detail sheet',
        widgetTester: tester,
      );

  VerifyVisibilityState get verifyDoctorSheetVisibilityState => getVerifyVisibilityStateFunction(
        finder: doctorsSheet,
        widgetName: 'Doctor sheet',
        widgetTester: tester,
      );

  VerifyVisibilityState get verifyNoDoctorsAroundFlushbarVisibilityState =>
      getVerifyVisibilityStateFunction(
        finder: noDoctorsAroundFlushbar,
        widgetName: 'No doctors around Flushbar',
        widgetTester: tester,
      );

  Future<void> dragSheetUp() async {
    logTestEvent();
    await tester.drag(doctorsSheetHandle, const Offset(0, -200));
    await tester.pumpAndSettle();
  }

  /// Verifies that the [loadingIndicator] nor [errorIndicator] is visible (or waits a bit).
  Future<void> verifyControlComponentsAreShown() async {
    logTestEvent();
    await tester.pumpUntilNotFound(loadingIndicator);
    await tester.pumpUntilNotFound(errorIndicator);
    await tester.pumpUntilFound(mainSearchField);
  }

  Future<void> clickSearchField() async {
    logTestEvent();
    await tester.tap(mainSearchField);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> clickCloseButton() async {
    logTestEvent();
    await tester.tap(closeButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> clickClearSpecialization() async {
    logTestEvent();
    await tester.tap(mainSearchFieldSpecClear);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(FindDoctorScreen));
  }
}
