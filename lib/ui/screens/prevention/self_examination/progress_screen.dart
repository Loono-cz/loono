import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';

class ProgressRewardScreen extends StatelessWidget {
  const ProgressRewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.no_findings_progress_desc),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
