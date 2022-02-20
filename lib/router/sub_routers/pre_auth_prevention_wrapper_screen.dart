import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class PreAuthPreventionWrapperScreen extends StatefulWidget {
  const PreAuthPreventionWrapperScreen({
    Key? key,
    this.forceRoute,
  }) : super(key: key);

  final PageRouteInfo? forceRoute;

  @override
  State<PreAuthPreventionWrapperScreen> createState() => _PreAuthPreventionWrapperScreenState();
}

class _PreAuthPreventionWrapperScreenState extends State<PreAuthPreventionWrapperScreen> {
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: widget.forceRoute != null
          ? AutoRouter.declarative(routes: (_) => [widget.forceRoute!])
          : StreamBuilder<List<ExaminationQuestionnaire>?>(
              stream: _examinationQuestionnairesDao.watchAll(),
              builder: (context, snapshot) {
                final examinationQuestionnaires = snapshot.data;

                return AutoRouter.declarative(
                  routes: (context) {
                    if (snapshot.hasData) {
                      if (examinationQuestionnaires != null) {
                        if (examinationQuestionnaires.isOnboardingDone) {
                          return [OnboardingFormDoneRoute()];
                        }

                        if (examinationQuestionnaires.isOnboardingInProgress) {
                          return [ContinueOnboardingFormRoute()];
                        }
                      }

                      return [const StartNewQuestionnaireRoute()];
                    }

                    return [];
                  },
                );
              },
            ),
    );
  }
}
