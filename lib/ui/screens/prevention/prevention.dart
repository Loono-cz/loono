import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // TODO: Only user with created account can open Settings
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () => AutoRouter.of(context).push(OpenSettingsRoute()),
                child: const Text('SETTINGS'),
              ),
            ),
            const BadgeComposer(),
            ExaminationsSheetOverlay(),
          ],
        ),
      ),
    );
  }
}
