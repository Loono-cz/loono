import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono_api/src/model/sex.dart';


void showHowItWentSheet(BuildContext context, Sex sex) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return LoonBottomSheet(
        sheetHeight: 400,
        child: Column(
          children: <Widget>[
            const Text(
              'Jak to dopadlo?',
              style: LoonoFonts.headerFontStyle,
            ),
            const SizedBox(height: 60),
            LoonoButton.light(
              text: 'Je to v pořádku',
              onTap: () {
                AutoRouter.of(context).push(const NoFindingRoute());
              },
            ),
            const SizedBox(height: 20),
            LoonoButton.light(
              text: 'Něco jsem našla',
              onTap: () => AutoRouter.of(context).push(HasFindingRoute(sex: sex)),
            ),
          ],
        ),
      );
    },
  );
}
