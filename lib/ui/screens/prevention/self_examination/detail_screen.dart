import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';
import 'package:loono_api/loono_api.dart';

class SelfExaminationDetailScreen extends StatelessWidget {
  const SelfExaminationDetailScreen({Key? key, required this.sex}) : super(key: key);
  final Sex sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: LoonoButton(
                      text: 'Vyšetřila jsem se',
                      onTap: () {
                        showHowItWentSheet(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 19),
                  Expanded(
                    child: LoonoButton.light(
                      text: 'Jak se vyšetřit', //mám objednáno
                      onTap: () => AutoRouter.of(context).push(EducationalVideoRoute(sex: sex)),
                    ),
                  ),
                ],
              ),
              const Text('Samovyšetření prsa'),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
