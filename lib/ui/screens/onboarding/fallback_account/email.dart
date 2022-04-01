import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/nickname_hint_resolver.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/helpers/validators.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/ui/widgets/onboarding/app_bar.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({
    Key? key,
    required this.socialLoginAccount,
  }) : super(key: key);

  final SocialLoginAccount socialLoginAccount;

  final _apiService = registry.get<ApiService>();
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;
  final _usersDao = registry.get<DatabaseService>().users;
  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        return FallbackAccountContent(
          appBar: createAccountAppBar(context, step: 2),
          title: context.l10n.fallback_account_email,
          initialText: socialLoginAccount.email,
          buttonText: context.l10n.create_new_account,
          hint: '${getHintText(context, user: snapshot.data).toLowerCase()}@seznam.cz',
          description: context.l10n.fallback_account_email_desc,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email(context),
          onSubmit: (input) async {
            await _usersDao.updateCurrentUser(UsersCompanion(email: Value(input)));
            final createAccountResult = await socialLoginAccount.createAccount();
            createAccountResult.fold(
              (failure) => showFlushBarError(context, context.l10n.something_went_wrong),
              (authUser) async {
                final user = _usersDao.user;
                final examinationQuestionnaires = await _examinationQuestionnairesDao.getAll();

                final result = await _callOnboardUser(authUser, user, examinationQuestionnaires);
                await result.when(
                  success: (account) async {
                    await _userRepository.updateCurrentUserFromAccount(account);
                    await AutoRouter.of(context).replaceAll([GamificationIntroductionRoute()]);
                  },
                  failure: (_) async {
                    showFlushBarError(context, context.l10n.something_went_wrong);
                    // delete account so user can not login without saving info to server first
                    await authUser.delete();
                  },
                );
              },
            );
            return null;
          },
        );
      },
    );
  }

  Future<ApiResponse<Account>> _callOnboardUser(
    AuthUser authUser,
    User? user,
    List<ExaminationQuestionnaire> examinationQuestionnaires,
  ) async {
    if (user == null || examinationQuestionnaires.isEmpty) {
      return ApiResponse.failure(DioError(requestOptions: RequestOptions(path: '')));
    }
    final generalPractitioner = examinationQuestionnaires.generalPractitionerQuestionnaire;
    final gynecologist = examinationQuestionnaires.gynecologistQuestionnaire;
    final dentist = examinationQuestionnaires.dentistQuestionnaire;
    final onboardingQuestionnaires = [
      generalPractitioner,
      if (user.sex == Sex.FEMALE) gynecologist,
      dentist,
    ].whereType<ExaminationQuestionnaire>();

    return _apiService.onboardUser(
      sex: user.sex!,
      birthdate: user.dateOfBirth!,
      examinations: BuiltList.from(
        <ExaminationRecord>[
          for (final questionnaire in onboardingQuestionnaires)
            ExaminationRecord((b) {
              b
                ..status = questionnaire.status
                ..date = getFakeUtcDate(questionnaire.date)
                ..firstExam = true
                ..type = questionnaire.type;
            })
        ],
      ),
      nickname: user.nickname ?? '',
      preferredEmail: user.email ?? '',
    );
  }
}
