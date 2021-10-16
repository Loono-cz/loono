import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/nickname_hint_resolver.dart';
import 'package:loono/helpers/validators.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/utils/registry.dart';

class EditNicknameScreen extends StatelessWidget {
  EditNicknameScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return FallbackAccountContent(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      title: context.l10n.fallback_account_name,
      initialText: user?.nickname,
      hint: getHintText(context, user: user),
      buttonText: context.l10n.action_save,
      filled: true,
      keyboardType: TextInputType.name,
      validator: Validators.nickname(context),
      onSubmit: (input) async {
        await _usersDao.updateNickname(input);
        AutoRouter.of(context).pop();
      },
    );
  }
}
