import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

enum ViewSteps { overView, interval, datePicker }

void showEditSheet({
  required BuildContext context,
  required CategorizedExamination categorizedExamination,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return Container(
        key: const Key('editExaminationSheet'),
        height: 680,
        decoration: const BoxDecoration(
          color: LoonoColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: _ExaminationEditContent(categorizedExamination: categorizedExamination),
          ),
        ),
      );
    },
  ).whenComplete(() {
    // registry.get<FirebaseAnalytics>().logEvent(name: 'CloseConfirmCheckupModal');
  });
}

class _ExaminationEditContent extends StatefulWidget {
  const _ExaminationEditContent({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  @override
  _ExaminationEditContentState createState() => _ExaminationEditContentState();
}

class _ExaminationEditContentState extends State<_ExaminationEditContent> {
  DateTime? newDate;

  void onDateChanged(DateTime date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        newDate = date;
      });
    });
  }

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  var viewStep = ViewSteps.overView;

  @override
  Widget build(BuildContext context) {
    final originalDate = widget.categorizedExamination.examination.plannedDate?.toLocal();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            const Spacer(),
            LoonoCloseButton(onPressed: () => AutoRouter.of(context).pop()),
          ],
        ),
        const SizedBox(
          height: 21,
        ),
        Row(
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: buildTitle(viewStep),
                      style: LoonoFonts.headerFontStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        buildStepView(
          viewStep,
          originalDate,
        )
      ],
    );
  }

  Widget buildStepView(ViewSteps view, DateTime? originalDate) {
    switch (view) {
      case ViewSteps.overView:
        return Center(
          child: Container(),
        );
      case ViewSteps.interval:
        return Container();
      case ViewSteps.datePicker:
        return Center(
          child: CustomDatePicker(
            valueChanged: onDateChanged,
            yearsBeforeActual: DateTime.now().year - 1900,
            yearsOverActual: 2,
            allowDays: true,
            defaultDay: originalDate?.day,
            defaultMonth: originalDate?.month,
            defaultYear: originalDate?.year,
          ),
        );
    }
  }

  String buildTitle(ViewSteps view) {
    switch (view) {
      case ViewSteps.overView:
        return 'Upravit prohlidku';
      case ViewSteps.interval:
        return 'Jak casto na vysetreni chodis?';
      case ViewSteps.datePicker:
        return _sex == Sex.MALE
            ? 'Kdy naposled jsi byl na prohlidce?'
            : 'Kdy naposled jsi byla na prohlidce?';
      default:
        return '';
    }
  }
}
