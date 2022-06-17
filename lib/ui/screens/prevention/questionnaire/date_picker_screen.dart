import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';

import '../../../../helpers/flushbar_message.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.onContinueButtonPress,
    this.onSkipButtonPress,
  }) : super(key: key);

  final String assetPath;
  final String title;
  final ValueChanged<DateTime>? onContinueButtonPress;
  final ValueChanged<DateTime>? onSkipButtonPress;

  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    const imageAssetSize = 50.0;

    return WillPopScope(
      onWillPop: () async => false,
      child: PreventiveExaminationDatePickerScreen(
        image: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: imageAssetSize,
            height: imageAssetSize,
            color: LoonoColors.beigeLighter,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: -10,
                  child: SvgPicture.asset(widget.assetPath, width: imageAssetSize),
                ),
              ],
            ),
          ),
        ),
        title: widget.title,
        onDateChanged: (value) => selectedDate = value,
        onSkipButtonPress: () => widget.onSkipButtonPress?.call(DateTime.now()),
        onContinueButtonPress: () {
          if (selectedDate == null) return;
          if (selectedDate?.isAfter(DateTime.now()) ?? true) {
            showFlushBarError(
              context,
              context.l10n.datepicker_error_user_input,
            );
          } else {
            widget.onContinueButtonPress?.call(selectedDate!);
          }
        },
      ),
    );
  }
}
