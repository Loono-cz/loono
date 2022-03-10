import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart' as db;
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class SelfExaminationCard extends StatelessWidget {
  SelfExaminationCard({
    Key? key,
    required this.onTap,
    required this.selfExamination,
  }) : super(key: key);

  final now = DateTime.now();

  final void Function(Sex)? onTap;
  final SelfExaminationPreventionStatus selfExamination;

  Widget get _title => Text(selfExamination.type.l10n_name, style: LoonoFonts.cardTitle);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<db.User?>(
      stream: registry.get<DatabaseService>().users.watchUser(),
      builder: (context, snap) {
        if (snap.data == null) return const SizedBox.shrink();
        final sex = snap.data!.sex ?? Sex.MALE;
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          child: SizedBox(
            height: 120.0,
            child: InkWell(
              onTap: () {
                onTap?.call(sex);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selfExamination.calculateStatus().map(
                      first: (_) => _cardContent(
                        subtitle: context.l10n.start_with_self_examination_card_subtitle,
                      ),
                      active: (_) => _dateCardContent(
                        subtitle: context.l10n.active_self_examination_card_subtitle,
                        hasPriority: true,
                      ),
                      waiting: (_) {
                        final formattedDate = DateFormat('d. M. yyyy', 'cs-CZ')
                            .format(selfExamination.plannedDate!.toDateTime().toLocal());
                        return _dateCardContent(
                          subtitle:
                              '${context.l10n.waiting_self_examination_card_subtitle} $formattedDate',
                        );
                      },
                      // should get visible after 56 days, as hasFindingExpectingResult status
                      hasFinding: (_) => [const SizedBox.shrink()],
                      hasFindingExpectingResult: (_) => _cardContent(
                        subtitle:
                            context.l10n.has_finding_expecting_result_examination_card_subtitle,
                      ),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _cardContent({
    required String subtitle,
    bool topPriority = false,
  }) {
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
                  const SizedBox(width: 5),
                  if (topPriority)
                    SvgPicture.asset('assets/icons/prevention/appointment_soon.svg')
                  else
                    SvgPicture.asset('assets/icons/prevention/make_an_appointment.svg'),
                ],
              ),
              Text(
                subtitle.toUpperCase(),
                style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
              ),
              const SizedBox(height: 8.0),
              _loonoPointRow,
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.bottomRight, child: _doctorAsset),
    ];
  }

  List<Widget> _dateCardContent({
    required String subtitle,
    bool hasPriority = false,
  }) {
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
                  const SizedBox(width: 5),
                  if (hasPriority)
                    SvgPicture.asset('assets/icons/prevention/make_an_appointment.svg')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/prevention/calendar.svg'),
                  const SizedBox(width: 7.0),
                  Text(subtitle, style: LoonoFonts.cardSubtitle),
                ],
              ),
              const SizedBox(height: 5.0),
              _loonoPointRow,
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.bottomRight, child: _doctorAsset),
    ];
  }

  Widget get _doctorAsset => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          selfExamination.type.assetPath,
          width: 82,
        ),
      );

  Widget get _loonoPointRow {
    return Row(
      children: [
        const LoonoPointIcon(),
        const SizedBox(width: 7.0),
        Text(selfExamination.points.toString(), style: LoonoFonts.cardSubtitle),
      ],
    );
  }
}
