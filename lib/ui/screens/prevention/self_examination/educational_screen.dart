import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/ui/widgets/button.dart';

// TODO:
class EducationalVideoScreen extends StatelessWidget {
  const EducationalVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoonoButton(
                text: 'Vyšetřila jsem se',
                onTap: () => AutoRouter.of(context).pop(),
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
