import 'package:built_collection/built_collection.dart';
import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../../test_helpers/dart_objects_gens.dart';
import '../../../../app/flows/login_flow.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/educational_video_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-562)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final educationalVideoPage = EducationalVideoPage(tester);

  await app.runMockApp(charlatan: charlatan);
  final selfExam = defaultFemaleExaminations.selfexaminations.first.rebuild(
    (b) => b
      ..plannedDate = DateTime.now().add(const Duration(days: 10)).toDate()
      ..history = BuiltList.of(<SelfExaminationStatus>[
        SelfExaminationStatus.COMPLETED,
        SelfExaminationStatus.PLANNED,
      ]).toBuilder(),
  );
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: createExaminationsObject(
      examinations: defaultFemaleExaminations.examinations.toList(),
      selfExaminations: [selfExam],
    ),
  );

  const selfExamType = SelfExaminationType.BREAST;
  await preventionPage.verifySelfExaminationCardIsInCategory(
    selfExamType,
    expectedCategoryName: 'Připomenu ti vyšetření',
  );

  await preventionPage.clickSelfExaminationCard(selfExamType);
  await selfExaminationDetailPage.verifyScreenIsShown();

  await selfExaminationDetailPage.clickHowToSelfExamButton();
  await educationalVideoPage.verifyScreenIsShown();
  await educationalVideoPage.verifyVideoIsShown();
  educationalVideoPage.verifySelfExaminationPerformedButtonVisibilityState(isShown: false);
}
