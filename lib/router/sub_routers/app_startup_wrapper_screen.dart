import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
                // Remove the splash screen after we've got data and proceed routing.
                FlutterNativeSplash.remove();
                if (examinationQuestionnaires == null || examinationQuestionnaires.isEmpty) {
                  // first time opening app or onboarding questionnaire not started yet
                  return [WelcomeRoute()];
                } else {
                  return [PreAuthMainRoute()];
                }
              }

              // In this case, we're waiting till database gets initialized.
              // The splash screen is still displayed, so we don't need to
              // return any routes.
              return [];
            },
          );
        },
      ),
    );
  }
}
