import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';

import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding modal: [showHowItWentSheet]
class HowItWentModalPage {
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

  Future<void> verifyModalIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(modalContent);
  }

  Future<void> verifyModalIsNotShown() async {
    logTestEvent();
    await tester.pumpUntilNotFound(modalContent);
  }

  Future<void> closeModal() async {
    logTestEvent();
    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();
  }
}
