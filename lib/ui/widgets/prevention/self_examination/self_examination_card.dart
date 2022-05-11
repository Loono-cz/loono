import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart' as db;
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/notification_icon.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/progress_icons.dart';
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
                    if (selfExamination.calculateStatus() ==
                        const SelfExaminationCategory.waiting())
                      LoonoColors.greenLight
                    else
                      LoonoColors.pink,
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
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
                          hasFinding: (_) => _cardContent(
                            subtitle:
                                context.l10n.has_finding_expecting_result_examination_card_subtitle,
                            topPriority: null,
                          ),
                          hasFindingExpectingResult: (_) => _cardContent(
                            subtitle:
                                context.l10n.has_finding_expecting_result_examination_card_subtitle,
                            topPriority: true,
                          ),
                        ),
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
    bool? topPriority = false,
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
                  // if null, we hide red icon
                  if (topPriority == null)
                    const SizedBox.shrink()
                  // if topPriority true we show red icon with exclamation
                  else if (topPriority)
                    const NotificationIcon.topPriority()
                  // if topPriority false we just show red icon
                  else
                    const NotificationIcon.priority(),
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
      Stack(
        children: [
          _doctorCircle,
          Positioned(
            right: 0,
            bottom: 0,
            child: _doctorAsset,
          ),
        ],
      ),
    ];
  }

  List<Widget> _dateCardContent({
    required String subtitle,
    bool hasPriority = false,
  }) {
    final validStatuses = selfExamination.history.reversed.where(
      (item) => item == SelfExaminationStatus.COMPLETED || item == SelfExaminationStatus.PLANNED,
    );

    final offset = ((validStatuses.length - 1) / 3).floor();

    final iconList = List.generate(3, (index) {
      final absIndex = (offset * 3) + index;
      return absIndex < validStatuses.length ? validStatuses.elementAt(absIndex) : null;
    });

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
                  if (hasPriority) const NotificationIcon.priority()
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
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: iconList
                    .mapIndexed(
                      (index, item) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: index == 1 ? 3 : 0),
                        child: item == SelfExaminationStatus.COMPLETED
                            ? const SuccessIcon()
                            : item == SelfExaminationStatus.PLANNED
                                ? ProgressIcon(
                                    progress: selfExaminationProgress(selfExamination.plannedDate),
                                  )
                                : const EmptyIcon(),
                      ),
                    )
                    .toList(),
              ),
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

  Widget get _doctorAsset => Padding(
        padding: const EdgeInsets.only(
          right: 12.0,
          bottom: 15.0,
        ),
        child: SvgPicture.asset(
          selfExamination.type.assetPath,
          height: 82,
        ),
      );

  Widget get _doctorCircle => SvgPicture.asset(
        'assets/icons/card_circle.svg',
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
