import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class AppStartUpWrapperScreen extends StatefulWidget {
  const AppStartUpWrapperScreen({Key? key}) : super(key: key);

  @override
  State<AppStartUpWrapperScreen> createState() => _AppStartUpWrapperScreenState();
}

class _AppStartUpWrapperScreenState extends State<AppStartUpWrapperScreen> {
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder<List<ExaminationQuestionnaire>?>(
        stream: _examinationQuestionnairesDao.watchAll(),
        builder: (context, snapshot) {
          final examinationQuestionnaires = snapshot.data;

          return AutoRouter.declarative(
            routes: (context) {
              if (snapshot.hasData && snapshot.connectionState == ConnectionState.active) {
                if (examinationQuestionnaires == null || examinationQuestionnaires.isEmpty) {
                  // first time opening app or onboarding questionnaire not started yet
                  return [WelcomeRoute()];
                } else {
                  return [PreAuthMainRoute()];
                }
              }

              // TODO: Use native splash screen (https://cesko-digital.atlassian.net/browse/LOON-491)
              // placeholder till database gets initialized
              return [const SplashRoute()];
            },
          );
        },
      ),
    );
  }
}
