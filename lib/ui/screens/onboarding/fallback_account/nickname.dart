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
import 'package:moor/moor.dart';

class NicknameScreen extends StatelessWidget {
  NicknameScreen({
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
          appBar: createAccountAppBar(context, step: 1),
          title: context.l10n.fallback_account_name,
          initialText: socialLoginAccount?.nickname,
          hint: getHintText(context, user: snapshot.data),
          keyboardType: TextInputType.name,
          validator: Validators.nickname(context),
          onSubmit: (input) async {
            await _usersDao.updateCurrentUser(UsersCompanion(nickname: Value(input)));
            await AutoRouter.of(context).push(EmailRoute(socialLoginAccount: socialLoginAccount));
            return null;
          },
        );
      },
    );
  }
}
