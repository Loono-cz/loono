import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class PreventiveExaminationDatePickerScreen extends StatelessWidget {
  final Widget image;
  final String title;
  final ValueChanged onDateChanged;
  final void Function() onContinueButtonPress;
  final void Function()? onSkipButtonPress;

  const PreventiveExaminationDatePickerScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.onDateChanged,
    required this.onContinueButtonPress,
    this.onSkipButtonPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onSkipButtonPress != null) SkipButton(onPressed: onSkipButtonPress!),
              image,
              sizedBox,
              Text(title, style: LoonoFonts.bigFontStyle),
              sizedBox,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '${context.l10n.when_was_the_last_time} ',
                        style: LoonoFonts.fontStyle.copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: context.l10n.have_you_been_on_a_preventive_check_up_just_approximately,
                      style: LoonoFonts.fontStyle,
                    ),
                  ],
                ),
              ),
              sizedBox,
              Center(child: CustomDatePicker(valueChanged: onDateChanged)),
              const SizedBox(height: 25),
              LoonoButton(
                onContinueButtonPress,
                context.l10n.continue_info,
                enabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
