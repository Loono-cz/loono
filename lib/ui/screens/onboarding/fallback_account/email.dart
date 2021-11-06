import 'package:flutter/material.dart';
import 'package:loono/helpers/nickname_hint_resolver.dart';
import 'package:loono/helpers/validators.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';
import 'package:loono/utils/registry.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({Key? key, this.authUser}) : super(key: key);

  final AuthUser? authUser;

  final _usersDao = registry.get<DatabaseService>().users;
  final _userRepository = registry.get<UserRepository>();
  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        return FallbackAccountContent(
          title: context.l10n.fallback_account_email,
          initialText: authUser?.email,
          hint: '${getHintText(context, user: snapshot.data).toLowerCase()}@seznam.cz',
          description: context.l10n.fallback_account_email_desc,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email(context),
          onSubmit: (input) async {
            await _userRepository.updateEmail(input);
            await _authService.finishCreateAccountProcess();
          },
        );
      },
    );
  }
}
