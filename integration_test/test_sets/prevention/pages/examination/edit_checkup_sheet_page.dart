import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/widgets/prevention/examination_edit_modal.dart';

import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// Corresponding sheets: [showEditModal],
/// invoked from the: [ExaminationDetailScreen].
class EditCheckUpSheetPage {
  EditCheckUpSheetPage(this.tester);

  final WidgetTester tester;

  // Page finders
  final Finder editCheckUpSheet = find.byKey(const Key('editCheckUpDateSheet'));
  final Finder editCheckUpSheetEditDateAction =
      find.byKey(const Key('editCheckUpDateSheet_action_editDateCheckUp'));
  final Finder editCheckUpSheetCancelAction =
      find.byKey(const Key('editCheckUpDateSheet_action_cancelCheckUp'));
  final Finder cancelCheckUpSheet = find.byKey(const Key('cancelCheckUpSheet'));
  final Finder cancelCheckUpSheetConfirmBtn =
      find.byKey(const Key('cancelCheckUpSheet_btn_cancelCheckUp'));

  // Page methods
  Future<void> clickCancelCheckUpButton() async {
    logTestEvent();
    await tester.tap(editCheckUpSheetCancelAction);
    await tester.pumpAndSettle();
  }

  Future<void> confirmCancelCheckUpButton() async {
    logTestEvent();
    await tester.tap(cancelCheckUpSheetConfirmBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyEditCheckUpSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(editCheckUpSheet);
  }

  Future<void> verifyCancelCheckUpSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(cancelCheckUpSheet);
  }
}
