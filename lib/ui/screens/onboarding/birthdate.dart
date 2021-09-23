import 'package:flutter/material.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/utils/registry.dart';

class OnBoardingBirthdateScreen extends StatefulWidget {
  @override
  State<OnBoardingBirthdateScreen> createState() => _OnBoardingBirthdateScreenState();
}

class _OnBoardingBirthdateScreenState extends State<OnBoardingBirthdateScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SkipButton(onPressed: () => Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner')),
              const SizedBox(
                height: 70,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kdy ses narodil/a?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
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
                    await registry.get<DatabaseService>().users.updateDateOfBirth(
                        DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year));
                    Navigator.pushNamed(context, '/onboarding/doctor/general-practicioner');
                  }
                },
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
