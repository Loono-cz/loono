import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/models/user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/utils/registry.dart';

class NicknameScreen extends StatelessWidget {
  NicknameScreen({Key? key, this.authUser}) : super(key: key);

  final AuthUser? authUser;

  final _usersDao = registry.get<DatabaseService>().users;

  static String getHintText({required User? user, required AuthUser? authUser}) {
    final hasPredefinedHintText = authUser?.name != null;
    final String hintText;
    if (hasPredefinedHintText) {
      hintText = authUser!.name!;
    } else {
      if (user?.sex == null) {
        hintText = 'Ema';
      } else {
        hintText = user!.sex == Sex.male ? 'Adam' : 'Eva';
      }
    }
    return hintText;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        return FallbackAccountContent(
          title: context.l10n.fallback_account_name,
          initialText: authUser?.name?.split(' ').first,
          hint: getHintText(user: snapshot.data, authUser: authUser),
          keyboardType: TextInputType.name,
          validator: (input) {
            if (input == null || input.isEmpty) {
              return context.l10n.nickname_validator_empty_input;
            }
            if (input.length > 250) return context.l10n.nickname_validator_too_long_input;
          },
          onSubmit: (input) async {
            await _usersDao.updateNickname(input);
            AutoRouter.of(context).push(EmailRoute(authUser: authUser));
          },
        );
      },
    );
  }
}
