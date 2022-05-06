import 'package:flutter/material.dart';

class NoPermissionsScreen extends StatelessWidget {
  const NoPermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("no permission screen"),
      ),
    );
  }
}
