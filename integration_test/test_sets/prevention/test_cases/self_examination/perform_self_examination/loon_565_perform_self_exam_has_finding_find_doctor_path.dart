import 'package:built_collection/built_collection.dart';
import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../../test_helpers/dart_objects_gens.dart';
import '../../../../app/flows/login_flow.dart';
import '../../../../app/pages/post_auth_main_screen_page.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../../find_doctor/pages/find_doctor_page.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/has_finding_page.dart';
import '../../../pages/self_examination/detail/how_it_went_modal_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-565)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final mainScreenPage = PostAuthMainScreenPage(tester);
  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final howItWentModalPage = HowItWentModalPage(tester);
  final hasFindingPage = HasFindingPage(tester);
  final findDoctorPage = FindDoctorPage(tester);

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: defaultFemaleExaminations,
  );

  const selfExamType = SelfExaminationType.BREAST;
  const badgeReward = BadgeType.SHIELD;

  await preventionPage.verifySelfExaminationCardIsInCategory(
    selfExamType,
    expectedCategoryName: 'Vyšetři se',
  );
  preventionPage.verifyDoesNotHaveBadge(badgeReward);

  await preventionPage.clickSelfExaminationCard(selfExamType);
  await selfExaminationDetailPage.verifyScreenIsShown();
  selfExaminationDetailPage.verifySelfExaminationPerformedButtonState(isEnabled: true);

  charlatan
    ..whenPost(
      '/examinations/${selfExamType.name}/self',
      (request) {
        final data = request.body as Map<String, Object?>? ?? {};
        final result = data['result'] as String?;
        if (result == null) {
          return CharlatanHttpResponse(statusCode: 422, body: 'Error: Body is empty.');
        }
        expect(result, SelfExaminationResultResultEnum.FINDING.name);
        return CharlatanHttpResponse(
          statusCode: 200,
          body: standardSerializers.serializeWith(
            SelfExaminationCompletionInformation.serializer,
            createSelfExaminationCompletionInformationObject(
              points: 50,
              allPoints: defaultFemaleAccount.points + 50,
              badgeType: BadgeType.SHIELD,
              badgeLevel: 1,
              streak: 1,
            ),
          ),
        );
      },
    )
    ..whenGet(
      '/examinations',
      (_) {
        final updatedSelfExam = defaultFemaleExaminations.selfexaminations.first.rebuild(
          (b) => b
            ..plannedDate = DateTime.now().add(const Duration(days: 30)).toDate()
            ..history = BuiltList.of(<SelfExaminationStatus>[
              SelfExaminationStatus.WAITING_FOR_CHECKUP,
            ]).toBuilder(),
        );
        return standardSerializers.serializeWith(
          PreventionStatus.serializer,
          createExaminationsObject(
            examinations: defaultFemaleExaminations.examinations.toList(),
            selfExaminations: [updatedSelfExam],
          ),
        );
      },
    );

  await selfExaminationDetailPage.clickSelfExaminationPerformedButton();
  howItWentModalPage.verifyModalIsShown();

  await howItWentModalPage.clickHasFindingButton();
  await hasFindingPage.verifyScreenIsShown();
  hasFindingPage.verifyContentIsShown(textPattern: 'Nepanikař');

  await hasFindingPage.clickFindDoctorButton();
  await mainScreenPage.verifyScreenIsShown();
  await findDoctorPage.verifyScreenIsShown();

  await mainScreenPage.clickPreventionTab();
  await preventionPage.verifyScreenIsShown();
}
