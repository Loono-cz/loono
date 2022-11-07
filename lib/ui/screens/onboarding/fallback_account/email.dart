import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/nickname_hint_resolver.dart';
import 'package:loono/helpers/validators.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/social_login_account.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/ui/widgets/onboarding/app_bar.dart';
import 'package:loono/utils/registry.dart';
// ignore: depend_on_referenced_packages
import 'package:moor/moor.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({
    Key? key,
    required this.socialLoginAccount,
  }) : super(key: key);

  final SocialLoginAccount? socialLoginAccount;

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        return FallbackAccountContent(
          appBar: createAccountAppBar(context, step: 2),
          title: context.l10n.fallback_account_email,
          initialText: socialLoginAccount?.email,
          buttonText: context.l10n.confirm_info,
          hint: '${getHintText(context, user: snapshot.data).toLowerCase()}@seznam.cz',
          description: context.l10n.fallback_account_email_desc,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email(context),
          onSubmit: (input) async {
            final autoRouter = AutoRouter.of(context);
            await _usersDao.updateCurrentUser(UsersCompanion(email: Value(input)));
            await autoRouter.push(NewsletterAndGDPRRoute(socialLoginAccount: socialLoginAccount));
            return null;
          },
        );
      },
    );
  }
}
