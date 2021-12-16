import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/button.dart';

class ScheduleExamination extends StatelessWidget {
  const ScheduleExamination({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  Widget get _doctorAsset => SvgPicture.asset(
        categorizedExamination.examination.examinationType.assetName,
        width: 133,
      );

  String _czechPreposition() {
    if ([
      ExaminationType.COLONOSCOPY,
      ExaminationType.MAMMOGRAM,
    ].contains(categorizedExamination.examination.examinationType)) {
      return 'na';
    } else {
      return 'u';
    }
  }

  String _procedureQuestionTitle(BuildContext context) {
    var response = '';
    switch (categorizedExamination.examination.examinationType) {
      case ExaminationType.COLONOSCOPY:
        response = context.l10n.colonoscopy_question_highlight;
        break;
      case ExaminationType.DENTIST:
        response = context.l10n.dentist_question_highlight;
        break;
      case ExaminationType.DERMATOLOGIST:
        response = context.l10n.dermatology_question_highlight;
        break;
      case ExaminationType.GENERAL_PRACTITIONER:
        response = context.l10n.practitioner_question_highlight;
        break;
      case ExaminationType.GYNECOLOGIST:
        response = context.l10n.gynecology_question_highlight;
        break;
      case ExaminationType.MAMMOGRAM:
        response = context.l10n.mammogram_question_highlight;
        break;
      case ExaminationType.OPHTHALMOLOGIST:
        response = context.l10n.oculist_question_highlight;
        break;
      case ExaminationType.TESTICULAR_SELF:
        // TODO: Handle this case.
        break;
      case ExaminationType.TOKS:
        // TODO: Handle this case.
        break;
      case ExaminationType.ULTRASOUND_BREAST:
        // TODO: Handle this case.
        break;
      case ExaminationType.UROLOGIST:
        response = context.l10n.urology_question_highlight;
        break;
      case ExaminationType.BREAST_SELF:
        // TODO: Handle this case.
        break;
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              'assets/icons/prevention/arrow_back.svg',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Container(
                  width: 150,
                  height: 150,
                  color: LoonoColors.beigeLighter,
                  child: Stack(
                    children: [
                      Positioned(bottom: 0, left: -10, child: _doctorAsset),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Kdy jsi byl/a naposledy na ', style: LoonoFonts.paragraphFontStyle),
                    TextSpan(
                      text: 'preventivní prohlídce ',
                      style: LoonoFonts.paragraphFontStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: _czechPreposition(),
                      style: LoonoFonts.paragraphFontStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${_procedureQuestionTitle(context)}?'.toUpperCase(),
                style: LoonoFonts.headerFontStyle.copyWith(
                  color: LoonoColors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            children: [
              LoonoButton.light(
                text: context.l10n.practitioner_next_button1,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              LoonoButton.light(
                text: context.l10n.practitioner_next_button2,
                onTap: () {},
              ),
              const SizedBox(
                height: 62,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
