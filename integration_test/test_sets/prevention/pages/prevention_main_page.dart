import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class PreventionMainPage {
  PreventionMainPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder profileAvatar = find.byType(LoonoAvatar);

  /// Page methods
  Future<void> clickProfileAvatar() async {
    await tester.tap(profileAvatar);
    await tester.pumpSettleAndWait(seconds: 1);
  }
}
