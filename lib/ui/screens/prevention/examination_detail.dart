import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/button.dart';

class ExaminationDetailScreen extends StatelessWidget {
  const ExaminationDetailScreen({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: categorizedExamination.status == const ExaminationStatus.scheduledSoonOrOverdue()
            ? _ExaminationDetail(
                categorizedExamination: categorizedExamination,
              )
            : _ScheduleExaminations(
                categorizedExamination: categorizedExamination,
              ),
      ),
    );
  }
}

class _ExaminationDetail extends StatelessWidget {
  const _ExaminationDetail({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  Widget get _doctorAsset => SvgPicture.asset(
        categorizedExamination.examination.examinationType.assetName,
        width: 207,
      );

  Widget _calendarRow(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/prevention/calendar.svg'),
          const SizedBox(width: 5),
          Text(
            text,
            style: LoonoFonts.cardSubtitle,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final lastVisitDateWithoutDay = categorizedExamination.examination.lastVisitDate;
    final lastVisitDateTime = lastVisitDateWithoutDay != null
        ? DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month.index + 1)
        : null;
    final lastVisitYear = lastVisitDateWithoutDay != null ? lastVisitDateWithoutDay.year : '';
    final lastVisit = lastVisitDateTime != null
        ? "${DateFormat('MMMM', 'cs-CZ').format(lastVisitDateTime)} $lastVisitYear"
        : context.l10n.never;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        SizedBox(
          height: 207,
          child: Stack(
            children: [
              Positioned(
                right: -40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(107),
                  child: Container(
                    color: LoonoColors.beigeLighter,
                    child: _doctorAsset,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 16),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/prevention/arrow_back.svg',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Text(
                          categorizedExamination.examination.examinationType.name.toUpperCase(),
                          style: LoonoFonts.headerFontStyle.copyWith(
                            color: LoonoColors.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _calendarRow(
                            'Jednou za ${categorizedExamination.examination.interval.toString()} roky'),
                        const SizedBox(height: 10),
                        _calendarRow(
                          'Poslední prohlídka:\n$lastVisit',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Včasné objednání',
                textAlign: TextAlign.right,
                style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.red),
              ),
            )),
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Container(
                width: 160,
                height: 160,
                color: LoonoColors.beigeLighter,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Preventivní prohlídka',
                style: LoonoFonts.cardTitle
                    .copyWith(color: const Color(0xff635D58), fontWeight: FontWeight.w400),
              ),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: LoonoButton(
                  text: 'objednat se',
                  onTap: () {},
                ),
              ),
              const SizedBox(
                width: 19,
              ),
              Expanded(
                child: LoonoButton.light(
                  text: 'objednat se',
                  onTap: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ScheduleExaminations extends StatelessWidget {
  const _ScheduleExaminations({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  Widget get _doctorAsset => SvgPicture.asset(
        categorizedExamination.examination.examinationType.assetName,
        width: 150,
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
              'assets/icons/prevention/arrow_back.svg',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Container(
                  color: LoonoColors.beigeLighter,
                  child: _doctorAsset,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                context.l10n.universal_doctor_female_question,
                style: LoonoFonts.paragraphFontStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${categorizedExamination.examination.examinationType.name}?'.toUpperCase(),
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
