import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/ui/widgets/prevention/datepicker_sheet.dart';
import 'package:loono_api/loono_api.dart';

void showNewCheckupSheetStep1(
  BuildContext context,
  CategorizedExamination categorizedExamination,
  Future<void> Function({required DateTime date}) onSubmit,
  Sex sex,
) {
  final l10n = context.l10n;
  final examinationType = categorizedExamination.examination.examinationType;
  final autoRouter = AutoRouter.of(context);
  final cancelRoute = ExaminationDetailRoute(categorizedExamination: categorizedExamination);
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
            Row(
              children: [
                Text(
                  l10n.examination_detail_order_examination,
                  style: LoonoFonts.headerFontStyle,
                ),
              ],
            ),
            const SizedBox(height: 60),
            LoonoButton.light(
              text: '${l10n.i_have} ${examinationTypeCasus(
                context,
                casus: Casus.genitiv,
                examinationType: examinationType,
              ).toLowerCase()}',
              onTap: () {
                AutoRouter.of(context).popForced();
                showNewCheckupSheetStep2(context, categorizedExamination, onSubmit, sex);
              },
            ),
            const SizedBox(height: 20),
            LoonoButton.light(
              text: '${l10n.i_dont_have} ${examinationTypeCasus(
                context,
                casus: Casus.genitiv,
                examinationType: examinationType,
              ).toLowerCase()}',
              onTap: () => autoRouter.push(FindDoctorRoute(cancelRouteName: cancelRoute)),
            ),
          ],
        ),
      );
    },
  );
}

void showNewCheckupSheetStep2(
  BuildContext context,
  CategorizedExamination categorizedExamination,
  Future<void> Function({required DateTime date}) onSubmit,
  Sex sex,
) {
  final l10n = context.l10n;
  final examinationType = categorizedExamination.examination.examinationType;
  final autoRouter = AutoRouter.of(context);
  final cancelRoute = ExaminationDetailRoute(categorizedExamination: categorizedExamination);
  final preposition = czechPreposition(context, examinationType: examinationType);

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return LoonBottomSheet(
        sheetHeight: 567,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const CirceNumber(1),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: LoonoColors.leaderboardPrimary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${l10n.examination_call_doctor1} ${examinationTypeCasus(
                          context,
                          casus: Casus.dativ,
                          examinationType: examinationType,
                        ).toLowerCase()} ${l10n.examination_call_doctor2}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        l10n.preventive_inspection_plural.toLowerCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const CirceNumber(2),
            const SizedBox(height: 20),
            LoonoButton(
              text: l10n.examination_i_have_appointment_button,
              onTap: () {
                AutoRouter.of(context).popForced();
                showDatePickerSheet(
                  context: context,
                  categorizedExamination: categorizedExamination,
                  onSubmit: onSubmit,
                  firstStepTitle:
                      '${sex == Sex.MALE ? l10n.checkup_new_date_title_male : l10n.checkup_new_date_title_female} $preposition ${examinationTypeCasus(
                    context,
                    casus: Casus.genitiv,
                    examinationType: examinationType,
                  ).toUpperCase()}?',
                  secondStepTitle:
                      '${l10n.checkup_new_time_title} $preposition ${examinationTypeCasus(
                    context,
                    casus: Casus.nomativ,
                    examinationType: examinationType,
                  ).toLowerCase()}',
                );
              },
            ),
            const SizedBox(height: 50),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 40),
              ),
              onPressed: () => autoRouter.push(
                FindDoctorRoute(cancelRouteName: cancelRoute),
              ),
              child: Text(
                '${l10n.examination_dont_have_number_button} ${examinationTypeCasus(
                  context,
                  casus: Casus.genitiv,
                  examinationType: examinationType,
                ).toLowerCase()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class CirceNumber extends StatelessWidget {
  const CirceNumber(this.number, {Key? key}) : super(key: key);

  final int number;
  final double size = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          number.toString(),
        ),
      ),
    );
  }
}
