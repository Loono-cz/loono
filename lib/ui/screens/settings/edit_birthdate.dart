import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/utils/registry.dart';

class EditBirthdateScreen extends StatefulWidget {
  const EditBirthdateScreen({Key? key}) : super(key: key);

  @override
  State<EditBirthdateScreen> createState() => _EditBirthdateScreenState();
}

class _EditBirthdateScreenState extends State<EditBirthdateScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 34.0),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  context.l10n.update_profile_birthdate,
                  style: const TextStyle(fontSize: 16.0, color: LoonoColors.black),
                ),
              ),
              Expanded(
                child: Center(
                  child: CustomDatePicker(
                    valueChanged: (val) => selectedDate = val,
                    yearsOverActual: 0,
                    defaultMonth: DateTime.january,
                    defaultYear: DateTime.now().year - 35,
                    filled: true,
                  ),
                ),
              ),
              LoonoButton(
                text: context.l10n.action_save,
                onTap: () async {
                  if (selectedDate != null) {
                    await registry.get<DatabaseService>().users.updateDateOfBirth(DateWithoutDay(
                        month: monthFromInt(selectedDate!.month), year: selectedDate!.year));
                  }
                  AutoRouter.of(context).pop();
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
