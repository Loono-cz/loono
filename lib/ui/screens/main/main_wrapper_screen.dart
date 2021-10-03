import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';

class MainWrapperScreen extends StatelessWidget {
  const MainWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoRouter.declarative(
      routes: (context) {
        return [const MainRoute()];
      },
    );
  }
}
