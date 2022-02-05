import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';

void showOrderCheckupSheet(BuildContext context, CategorizedExamination categorizedExamination) {
  final l10n = context.l10n;
  final examinationType = categorizedExamination.examination.examinationType;
  final autoRouter = AutoRouter.of(context);
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return LoonBottomSheet(
        sheetHeight: 400,
        child: Column(
          children: <Widget>[
            Text(
              l10n.examination_detail_order_examination,
              style: LoonoFonts.headerFontStyle,
            ),
            const SizedBox(height: 60),
            LoonoButton.light(
              text: '${l10n.i_have} ${examinationTypeCasus(
                context,
                casus: Casus.genitiv,
                examinationType: examinationType,
              ).toLowerCase()}',
              onTap: () {
                autoRouter
                    .push(OrderExaminationRoute(categorizedExamination: categorizedExamination));
              },
            ),
            const SizedBox(height: 20),
            LoonoButton.light(
              text: '${l10n.i_dont_have} ${examinationTypeCasus(
                context,
                casus: Casus.genitiv,
                examinationType: examinationType,
              ).toLowerCase()}',
              onTap: () => autoRouter.push(FindDoctorRoute(enableAppBar: true)),
            ),
          ],
        ),
      );
    },
  );
}
