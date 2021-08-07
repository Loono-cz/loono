import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class GynecologyDateScreen extends StatelessWidget {
  const GynecologyDateScreen({Key? key}) : super(key: key);

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
              SkipButton(onPressed: () => Navigator.pushNamed(context, '/create-account')),
              SvgPicture.asset('assets/icons/gynecology.svg', width: 50),
              sizedBox,
              Text(context.l10n.gynecology, style: LoonoFonts.bigFontStyle),
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
              Center(child: CustomDatePicker(valueChanged: (value) => print(value))),
              const SizedBox(height: 25),
              LoonoButton(
                () => Navigator.pushNamed(context, '/create-account'),
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
