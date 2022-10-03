import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_action_types.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/notification_icon.dart';
import 'package:loono_api/loono_api.dart';

// ignore: constant_identifier_names
const EXAMINATION_CARD_HEIGHT = 130.0;

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

  Widget _title(BuildContext? context) => Text(
        categorizedExamination.examination.examinationType.getName(context),
        style: LoonoFonts.cardTitle,
      );
  Widget get _subtitle => Text(
        ExaminationActionTypeExt(
          categorizedExamination.examination.examinationActionType ?? ExaminationActionType.CONTROL,
        ).l10n_name,
        style: LoonoFonts.cardExaminaitonType,
      );

  Widget get _doctorAsset => SvgPicture.asset(
        categorizedExamination.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM
            ? categorizedExamination.examination.examinationType.customExamAssetPath
            : categorizedExamination.examination.examinationType.assetPath,
        height: 100,
      );

  Widget get _doctorCircle => SvgPicture.asset(
        'assets/icons/card_circle.svg',
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: EXAMINATION_CARD_HEIGHT,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                if (categorizedExamination.category == const ExaminationCategory.waiting())
                  LoonoColors.greenLight
                else
                  LoonoColors.pink,
              ],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categorizedExamination.category.when(
                  scheduledSoonOrOverdue: () => _scheduledContent(isSoonOrOverdue: true, context: context),
                  newToSchedule: () => _makeAppointmentContent(context, isNew: true),
                  unknownLastVisit: () => _makeAppointmentContent(context),
                  scheduled:() {
                    return _scheduledContent(context: context);
                  },
                  waiting: () => _waitingContent(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _scheduledContent({bool isSoonOrOverdue = false, required BuildContext context}) {
    final nextVisitDate = categorizedExamination.examination.plannedDate!.toLocal();
    final diffDays = _diffInDays(nextVisitDate);
    // final diffText = now.isAfter(nextVisitDate)
    //     ? 'byl/a jsi na prohlídce?'
    //     : diffDays == 0
    //         ? 'dnes'
    //         : diffDays == 1
    //             ? 'zítra'
    //             : '';


    final diffText = diffDays == 0
        ? context.l10n.today.toLowerCase()
        : diffDays == 1
            ? context.l10n.today
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
                  _title(context),
                  if (isSoonOrOverdue) ...[
                    const SizedBox(width: 5),
                    const NotificationIcon.topPriority(),
                  ],
                ],
              ),
              _subtitle,
              const SizedBox(height: 8.0),
              dateRow(isSoonOrOverdue ? diffText : ''),
              const SizedBox(height: 5.0),
              loonoPointRow(),
            ],
          ),
        ),
      ),
      Stack(
        children: [
          _doctorCircle,
          Positioned(
            right: 0,
            bottom: 0,
            child: _doctorAsset,
          ),
        ],
      )
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
                  _title(context),
                  if (isNew && index == 0) ...[
                    const SizedBox(width: 5),
                    const NotificationIcon.priority(),
                  ],
                ],
              ),
              _subtitle,
              const SizedBox(
                height: 4.0,
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
      Stack(
        children: [
          _doctorCircle,
          Positioned(
            right: 0,
            bottom: 0,
            child: _doctorAsset,
          ),
        ],
      )
    ];
  }

  List<Widget> _waitingContent(BuildContext context) {
    final lastDateVisit = categorizedExamination.examination.lastConfirmedDate!.toLocal();
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
              _title(context),
              const SizedBox(
                height: 2.0,
              ),
              _subtitle,
              const Spacer(flex: 2),
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
            _doctorCircle,
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

  Widget dateRow(String diffText) {
    final formattedDate = DateFormat('d. M. yyyy HH:mm', 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());

    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        SvgPicture.asset('assets/icons/prevention/calendar.svg'),
        const SizedBox(width: 7.0),
        Text(formattedDate, style: LoonoFonts.cardSubtitle),
        const SizedBox(
          width: 10,
        ),
        Text(
          diffText.toUpperCase(),
          style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
        )
      ],
    );
  }

  Widget loonoPointRow() {
    final points = categorizedExamination.examination.points;

    return points > 0
        ? Row(
            children: [
              const LoonoPointIcon(),
              const SizedBox(width: 7.0),
              Text(points.toString(), style: LoonoFonts.cardSubtitle),
            ],
          )
        : Container();
  }
}
