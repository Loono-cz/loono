import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class OnBoardingBirthdateScreen extends StatefulWidget {
  const OnBoardingBirthdateScreen({Key? key, required this.sex}) : super(key: key);

  final Sex sex;

  @override
  State<OnBoardingBirthdateScreen> createState() => _OnBoardingBirthdateScreenState();
}

class _OnBoardingBirthdateScreenState extends State<OnBoardingBirthdateScreen> {
  DateTime? selectedDate;

  int _calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
    final month1 = currentDate.month;
    final month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SkipButton(
                onPressed: () => AutoRouter.of(context).push(const FillOnboardingFormLaterRoute()),
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sex.getBirthdateLabel(context),
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.birthdate_subtitle.split('\n')[0],
                      style: LoonoFonts.paragraphSmallFontStyle,
                    ),
                    Text(
                      context.l10n.birthdate_subtitle.split('\n')[1],
                      style: LoonoFonts.paragraphSmallFontStyle,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CustomDatePicker(
                      valueChanged: (val) {
                        selectedDate = val;
                      },
                      yearsOverActual: 0,
                      defaultMonth: DateTime.january,
                      defaultYear: DateTime.now().year - 35,
                    ),
                  ),
                ),
              ),
              LoonoButton(
                text: context.l10n.continue_info,
                onTap: () async {
                  if (selectedDate != null) {
                    if (_calculateAge(selectedDate!) > 19) {
                      await registry.get<UserRepository>().updateDateOfBirth(
                            DateWithoutDay(
                              month: monthFromInt(selectedDate!.month),
                              year: selectedDate!.year,
                            ),
                          );
                    } else {
                      showFlushBarError(
                        context,
                        'Prevence je zatím pro starší 19 let',
                        sync: false,
                      );
                    }
                  }
                },
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
