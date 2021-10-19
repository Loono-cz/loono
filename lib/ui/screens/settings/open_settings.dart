import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';

class OpenSettingsScreen extends StatelessWidget {
  const OpenSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context, showBackButton: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            // TODO: Update screen (https://cesko-digital.atlassian.net/browse/LOON-234)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(UpdateProfileRoute());
                },
                child: Text('UPDATE PROFILE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
