import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';

import '../../../../../test_helpers/e2e_action_logging.dart';
import '../../../../../test_helpers/pom_class_helpers.dart';

/// * Corresponding modal: [showHowItWentSheet]
class HowItWentModalPage with PomClassHelpers {
  HowItWentModalPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder modalContent = find.byKey(const Key('selfExaminationDetailPage_howItWentModal'));
  final Finder okBtn = find.byKey(const Key('selfExaminationDetailPage_howItWentModal_okBtn'));
  final Finder hasFindingBtn =
      find.byKey(const Key('selfExaminationDetailPage_howItWentModal_hasFindingBtn'));

  /// Page methods
  Future<void> clickOkButton() async {
    logTestEvent();
    await tester.tap(okBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickHasFindingButton() async {
    logTestEvent();
    await tester.tap(hasFindingBtn);
    await tester.pumpAndSettle();
  }

  VerifyVisibilityState get verifyHowItWentModalVisibilityState => getVerifyVisibilityStateFunction(
        finder: modalContent,
        widgetName: 'How it went modal',
        widgetTester: tester,
      );

  Future<void> closeModal() async {
    logTestEvent();
    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();
  }
}
