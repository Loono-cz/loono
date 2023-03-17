import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/models/examination_questionnaire.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/models/user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';

Future<void> submitAccount(
  BuildContext context,
  SocialLoginAccount? socialLoginAccount,
  AuthService authService,
  UsersDao usersDao,
  ExaminationQuestionnairesDao examinationQuestionnairesDao,
  ApiService apiService,
  UserRepository userRepository,
  bool newsletter,
) async {
  final Either<AuthFailure, AuthUser> createAccountResult;
  if (socialLoginAccount != null) {
    createAccountResult = await socialLoginAccount.createAccount();
  } else if (authService.isInBackendIntegrationTestingMode) {
    createAccountResult = await authService.signInWithCustomToken();
  } else {
    throw (Exception('Unknown sign in method'));
  }

  createAccountResult.fold(
    (failure) => showFlushBarError(context, context.l10n.something_went_wrong),
    (authUser) async {
      final autoRouter = AutoRouter.of(context);
      final user = usersDao.user;
      final examinationQuestionnaires = await examinationQuestionnairesDao.getAll();

      final result =
          await _callOnboardUser(authUser, user, examinationQuestionnaires, apiService, newsletter);
      await result.when(
        success: (account) async {
          await userRepository.updateCurrentUserFromAccount(account);
          await autoRouter.replaceAll([BadgeOverviewRoute()]);
        },
        failure: (_) async {
          // TODO: Tu to vyhodi chybovu hlasku a vymaze ucet z Firebase, ale v DB ostane
          // delete account so user can not login without saving info to server first
          showFlushBarError(context, context.l10n.something_went_wrong);
          await userRepository.deleteAccount();
          autoRouter.popUntilRoot();
        },
      );
    },
  );
}

Future<ApiResponse<Account>> _callOnboardUser(
  AuthUser authUser,
  User? user,
  List<ExaminationQuestionnaire> examinationQuestionnaires,
  ApiService apiService,
  bool newsletter,
) async {
  if (user == null || examinationQuestionnaires.isEmpty) {
    return ApiResponse.failure(
      DioError(requestOptions: RequestOptions(path: '')),
    );
  }
  final generalPractitioner = examinationQuestionnaires.generalPractitionerQuestionnaire;
  final gynecologist = examinationQuestionnaires.gynecologistQuestionnaire;
  final dentist = examinationQuestionnaires.dentistQuestionnaire;
  final onboardingQuestionnaires = [
    generalPractitioner,
    if (user.sex == Sex.FEMALE) gynecologist,
    dentist,
  ].whereType<ExaminationQuestionnaire>();

  return apiService.onboardUser(
    sex: user.sex!,
    birthdate: user.dateOfBirth!,
    examinations: BuiltList.from(
      <ExaminationRecord>[
        for (final questionnaire in onboardingQuestionnaires)
          ExaminationRecord((b) {
            b
              ..status = questionnaire.status
              ..plannedDate = questionnaire.date?.toUtc()
              ..firstExam = true
              ..type = questionnaire.type
              ..examinationCategoryType = ExaminationCategoryType.MANDATORY
              ..createdAt = Date.now();
          })
      ],
    ),
    nickname: user.nickname ?? '',
    preferredEmail: user.email ?? '',
    newsletterOptIn: newsletter,
  );
}
