import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
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
        // TODO: Use some real validation
        if (input == null) return '';
        if (input.isEmpty) return 'Prázdné pole';
        return null;
      },
      onSubmit: (input) async {
        await registry.get<DatabaseService>().users.updateNickname(input);
        Navigator.pushNamed(context, '/fallback_account/email');
      },
    );
  }
}
