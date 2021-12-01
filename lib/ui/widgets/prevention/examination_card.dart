import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

class ExaminationCard extends StatelessWidget {
  const ExaminationCard({
    Key? key,
    required this.categorizedExamination,
    required this.onTap,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final VoidCallback? onTap;

  int diffInDays(DateTime date) {
    final now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categorizedExamination.status.when(
                scheduledNowOrSoon: () => scheduled(isSoon: true),
                never: () => makeAppointmentContent(context),
                unfinished: () => makeAppointmentContent(context),
                scheduled: () => scheduled(),
                waiting: () => waiting(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> scheduled({bool isSoon = false}) {
    final diff = diffInDays(categorizedExamination.examination.nextVisitDate!);
    final diffText = diff == 0
        ? 'dnes'
        : diff == 1
            ? 'zítra'
            : diff < 0
                ? 'byla jsi na prohlídce?'
                : '';

    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categorizedExamination.examination.examinationType.name),
              if (isSoon) Text(diffText.toUpperCase()),
              ...[
                SizedBox(height: 8.0),
                dateRow(),
                loonoPointRow(),
              ],
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: SvgPicture.asset('assets/icons/gynecology.svg', width: 100),
      ),
    ];
  }

  List<Widget> makeAppointmentContent(BuildContext context, {bool showIndicator = false}) {
    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categorizedExamination.examination.examinationType.name),
              Text('objednej se'.toUpperCase()),
              Spacer(flex: 2),
              loonoPointRow(),
              Spacer(),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/icons/gynecology.svg', width: 100),
      ),
    ];
  }

  List<Widget> waiting() {
    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categorizedExamination.examination.examinationType.name),
              Spacer(),
              ...[
                Text(categorizedExamination.examination.examinationType.name),
                Text(categorizedExamination.examination.examinationType.name),
              ],
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/icons/gynecology.svg', width: 100),
      ),
    ];
  }

  Widget dateRow() {
    final formattedDate = DateFormat('dd. MM. yyyy kk:mm', 'cs-CZ')
        .format(categorizedExamination.examination.nextVisitDate!);

    return Row(
      children: [
        SvgPicture.asset('assets/icons/prevention/calendar.svg'),
        SizedBox(width: 7.0),
        Text(formattedDate),
      ],
    );
  }

  Widget loonoPointRow() {
    return Row(
      children: [
        LoonoPointIcon(),
        SizedBox(width: 7.0),
        Text(categorizedExamination.examination.worth.toString()),
      ],
    );
  }
}
