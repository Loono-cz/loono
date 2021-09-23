import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class OnboardingWrapperScreen extends StatefulWidget {
  const OnboardingWrapperScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingWrapperScreen> createState() => _OnboardingWrapperScreenState();
}

class _OnboardingWrapperScreenState extends State<OnboardingWrapperScreen> {
  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          return AutoRouter.declarative(
            routes: (context) {
              final user = snapshot.data;
              if (user == null) return [const OnboardingGenderRoute()];

              return [
                if (user.sexRaw == null) const OnboardingGenderRoute(),

                // male flow TODO:
                if (user.sexRaw == 0) ...[
                  if (user.dateOfBirthRaw == null) const OnBoardingBirthdateRoute(),
                  if (user.generalPracticionerCcaVisitRaw == null)
                    const OnboardingGeneralPracticionerRoute(),
                  // if (user.generalPracticionerCcaVisitRaw == null)
                  //   const OnboardingGeneralPracticionerRoute(),
                  // if (user.generalPracticionerCcaVisitRaw == null)
                  //   const OnboardingGeneralPracticionerRoute(),
                ],

                // female flow
                // TODO:
              ];

              // return [
              //   EmailRoute(onNext: (result) {
              //     setState(() {
              //       email: result;
              //     });
              //   }),
              //   if (email.isNotEmpty) PasswordRoute(onNext: (result) async {
              //     try {
              //       // validate the email and password
              //       await validateEmailAndPassword(email, result)
              //       widget.onLogin(true);
              //     } catch (e) {
              //       // do something with the error
              //     }
              //   }),
              // ];
            },
          );
        });
  }
}
