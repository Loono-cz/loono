import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [FindDoctorScreen]
class FindDoctorPage {
  FindDoctorPage(this.tester);

  final WidgetTester tester;

  /// Page finders

  /// Page methods
  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(FindDoctorScreen));
  }
}
