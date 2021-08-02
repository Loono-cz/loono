import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';

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
      onSubmit: (input) {
        // TODO: Save it to somewhere
        debugPrint(input);
        Navigator.pushNamed(context, '/fallback_account/email');
      },
    );
  }
}
