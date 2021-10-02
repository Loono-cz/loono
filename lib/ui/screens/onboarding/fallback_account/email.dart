import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/utils/registry.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({Key? key, this.authUser}) : super(key: key);

  final AuthUser? authUser;

  final _usersDao = registry.get<DatabaseService>().users;
  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        final nicknameHintText =
            NicknameScreen.getHintText(user: snapshot.data, authUser: authUser);

        return FallbackAccountContent(
          title: context.l10n.fallback_account_email,
          initialText: authUser?.email,
          hint: '${nicknameHintText.toLowerCase()}@seznam.cz',
          description: context.l10n.fallback_account_email_desc,
          keyboardType: TextInputType.emailAddress,
          validator: (input) {
            if (input == null || !EmailValidator.validate(input)) {
              return context.l10n.email_validator_wrong_input;
            }
          },
          onSubmit: (input) async {
            await registry.get<DatabaseService>().users.updateEmail(input);
            if (await _authService.getCurrentUser() == null) {
              _authService.signInAnonymously();
            }
            AutoRouter.of(context).push(MainWrapperRoute());
          },
        );
      },
    );
  }
}
