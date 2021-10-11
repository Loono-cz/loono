import 'package:flutter/material.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class AccountNotExistsScreen extends StatelessWidget {
  AccountNotExistsScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
