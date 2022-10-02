import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ChooseExamPeriodTimeScreen extends StatefulWidget {
  const ChooseExamPeriodTimeScreen({super.key, this.dateTime, required this.onTimeSet});

  final DateTime? dateTime;
  final Function(DateTime?) onTimeSet;
  @override
  State<ChooseExamPeriodTimeScreen> createState() => _ChooseExamPeriodTimeScreenState();
}

class _ChooseExamPeriodTimeScreenState extends State<ChooseExamPeriodTimeScreen> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();
  DateTime? _dateTime;
  DateTime _time = DateTime.now();

  final _usersDao = registry.get<DatabaseService>().users;

  String _getUserSexValue(BuildContext context, {required Sex? sex}) {
    late final String value;
    switch (sex) {
      case Sex.MALE:
        value = context.l10n.custom_exam_reservation_time_male;
        break;
      case Sex.FEMALE:
        value = context.l10n.custom_exam_reservation_time_female;
        break;
    }
    return value;
  }

  @override
  void initState() {
    super.initState();

    _dateTime =
        widget.dateTime?.add(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: LoonoColors.primaryLight50,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoonoCloseButton(onPressed: () async => _closeForm(context)),
          ),
        ],
      ),
      backgroundColor: LoonoColors.primaryLight50,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getUserSexValue(context, sex: _usersDao.user?.sex ?? Sex.FEMALE),
              style: LoonoFonts.customExamLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 1,
              child: CustomTimePicker(
                defaultHour: _dateTime?.hour,
                defaultMinute: _dateTime?.minute,
                valueChanged: (value) {
                  _time = value;
                },
                defaultDate: _dateTime ?? DateTime.now(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            LoonoButton(
              text: context.l10n.confirm_info,
              onTap: () {
                final isDateValid = Date.now().toDateTime().isAtSameMomentAs(
                          Date(_dateTime!.year, _dateTime!.month, _dateTime!.day).toDateTime(),
                        ) ||
                    DateTime.now().isBefore(_time);
                if (!isDateValid) {
                  showFlushBarError(context, context.l10n.error_must_be_in_future);
                  return;
                }

                final settedDate = _time;
                widget.onTimeSet(settedDate);
                AutoRouter.of(context).popUntilRouteWithName(CustomExamFormRoute.name);
              },
            )
          ],
        ),
      ),
    );
  }
}
