import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/utils/registry.dart';

class NicknameScreen extends StatelessWidget {
  const NicknameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FallbackAccountContent(
      title: context.l10n.fallback_account_name,
      hint: 'Ema',
      keyboardType: TextInputType.name,
      validator: (input) {
        if (input == null || input.isEmpty) return context.l10n.nickname_validator_empty_input;
        if (input.length > 250) return context.l10n.nickname_validator_too_long_input;
      },
      onSubmit: (input) async {
        await registry.get<DatabaseService>().users.updateNickname(input);
        AutoRouter.of(context).push(const EmailRoute());
      },
    );
  }
}
