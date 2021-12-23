import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
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
              'assets/icons/arrow_back.svg',
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
                      text: czechPreposition(categorizedExamination),
                      style: LoonoFonts.paragraphFontStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${procedureQuestionTitle(context, categorizedExamination)}?'.toUpperCase(),
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
