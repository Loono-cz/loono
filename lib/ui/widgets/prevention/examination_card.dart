import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/loono_point.dart';

class ExaminationCard extends StatelessWidget {
  ExaminationCard({
    Key? key,
    required this.index,
    required this.categorizedExamination,
    required this.onTap,
  }) : super(key: key);

  final now = DateTime.now();

  final int index;
  final CategorizedExamination categorizedExamination;
  final VoidCallback? onTap;

  int _diffInDays(DateTime date) => DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;

  Widget get _title => Text(
        categorizedExamination.examination.examinationType.l10n_name,
        style: LoonoFonts.cardTitle,
      );

  Widget get _doctorAsset => ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
        ),
        child: SvgPicture.asset(
          categorizedExamination.examination.examinationType.assetPath,
          width: 100,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: SizedBox(
        height: 120.0,
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categorizedExamination.category.when(
              scheduledSoonOrOverdue: () => _scheduledContent(isSoonOrOverdue: true),
              newToSchedule: () => _makeAppointmentContent(context, isNew: true),
              unknownLastVisit: () => _makeAppointmentContent(context),
              scheduled: _scheduledContent,
              waiting: _waitingContent,
              selfExamination: () => [const SizedBox.shrink()],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _scheduledContent({bool isSoonOrOverdue = false}) {
    final nextVisitDate = categorizedExamination.examination.plannedDate!.toLocal();
    final diffDays = _diffInDays(nextVisitDate);
    final diffText = now.isAfter(nextVisitDate)
        ? 'byl/a jsi na prohlídce?'
        : diffDays == 0
            ? 'dnes'
            : diffDays == 1
                ? 'zítra'
                : '';

    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: const EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _title,
                  if (isSoonOrOverdue) ...[
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/prevention/appointment_soon.svg'),
                  ],
                ],
              ),
              if (isSoonOrOverdue)
                Text(
                  diffText.toUpperCase(),
                  style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                ),
              const SizedBox(height: 8.0),
              dateRow(),
              const SizedBox(height: 5.0),
              loonoPointRow(),
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.bottomRight, child: _doctorAsset),
    ];
  }

  List<Widget> _makeAppointmentContent(BuildContext context, {bool isNew = false}) {
    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: const EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _title,
                  if (isNew && index == 0) ...[
                    const SizedBox(width: 5),
                    SvgPicture.asset('assets/icons/prevention/make_an_appointment.svg'),
                  ],
                ],
              ),
              Text(
                'objednej se'.toUpperCase(),
                style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
              ),
              const Spacer(flex: 2),
              loonoPointRow(),
              const Spacer(),
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.bottomRight, child: _doctorAsset),
    ];
  }

  List<Widget> _waitingContent() {
    final lastDateVisit = categorizedExamination.examination.lastConfirmedDate!;
    final newWaitToDateTime = DateTime(
      lastDateVisit.year + categorizedExamination.examination.intervalYears,
      lastDateVisit.month,
    );
    final formattedDate = DateFormat.yMMMM('cs-CZ').format(newWaitToDateTime);

    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: const EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title,
              Text(
                'do $formattedDate hotovo'.toUpperCase(),
                style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
              ),
              const Spacer(flex: 2),
              loonoPointRow(),
              const Spacer(),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const SizedBox(width: 150),
            _doctorAsset,
            Positioned(
              bottom: 10,
              right: 80,
              child: SvgPicture.asset('assets/icons/prevention/success_checkmark.svg', width: 50),
            ),
          ],
        ),
      ),
    ];
  }

  Widget dateRow() {
    final formattedDate = DateFormat('d. M. yyyy kk:mm', 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());

    return Row(
      children: [
        SvgPicture.asset('assets/icons/prevention/calendar.svg'),
        const SizedBox(width: 7.0),
        Text(formattedDate, style: LoonoFonts.cardSubtitle),
      ],
    );
  }

  Widget loonoPointRow() {
    return Row(
      children: [
        const LoonoPointIcon(),
        const SizedBox(width: 7.0),
        Text(categorizedExamination.examination.count.toString(), style: LoonoFonts.cardSubtitle),
      ],
    );
  }
}
