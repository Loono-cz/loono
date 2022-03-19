import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class PreventiveExaminationDatePickerScreen extends StatelessWidget {
  const PreventiveExaminationDatePickerScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.onDateChanged,
    required this.onContinueButtonPress,
    this.onSkipButtonPress,
  }) : super(key: key);

  final Widget image;
  final String title;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onContinueButtonPress;
  final VoidCallback? onSkipButtonPress;

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onSkipButtonPress != null)
                SkipButton(text: context.l10n.skip_idk, onPressed: onSkipButtonPress!),
              sizedBox,
              sizedBox,
              image,
              sizedBox,
              Text(title, style: LoonoFonts.bigFontStyle.copyWith(fontSize: 24)),
              sizedBox,
              Text(context.l10n.check_up_body_text, style: LoonoFonts.fontStyle),
              const Spacer(),
              Center(
                child: CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: DateTime.now().year - 1900,
                  yearsOverActual: 0,
                ),
              ),
              const Spacer(),
              LoonoButton(
                onTap: onContinueButtonPress,
                text: context.l10n.continue_info,
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
