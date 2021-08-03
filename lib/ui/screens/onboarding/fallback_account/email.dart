import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FallbackAccountContent(
      title: context.l10n.fallback_account_email,
      hint: 'ema@seznam.cz',
      description: context.l10n.fallback_account_email_desc,
      keyboardType: TextInputType.emailAddress,
      validator: (input) {
        // TODO: Use some real validation
        if (input == null) return '';
        if (!input.contains('@')) return 'Chybí @';
        return null;
      },
      onSubmit: (input) {
        // TODO: Save it to somewhere
        debugPrint(input);
      },
    );
  }
}
