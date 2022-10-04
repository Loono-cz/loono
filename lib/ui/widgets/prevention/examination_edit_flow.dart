import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_input_text_field.dart';
import 'package:loono/ui/widgets/radio_button.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

void showExaminationEditSheet({
  required BuildContext context,
  Widget? forWidget,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        key: const Key('editExaminationSheet'),
        height: 680,
        decoration: const BoxDecoration(
          color: LoonoColors.primaryLight50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: forWidget ?? const _ExaminationEditContent(),
          ),
        ),
      );
    },
  ).whenComplete(() {
    //356 TODO: analytics?
    // registry.get<FirebaseAnalytics>().logEvent(name: 'CloseConfirmCheckupModal');
  });
}

class _ExaminationEditContent extends StatefulWidget {
  const _ExaminationEditContent({
    Key? key,
  }) : super(key: key);

  @override
  _ExaminationEditContentState createState() => _ExaminationEditContentState();
}

class _ExaminationEditContentState extends State<_ExaminationEditContent> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();
  bool _standardFreqSelected = false;
  bool _freqSelected = false;
  bool _nextExamDunno = false;
  // final bool _showError = false;
  String _customInterval = '';
  DateTime? _nextExamDate;

  final _usersDao = registry.get<DatabaseService>().users;

  String _getUserLabelBySex(BuildContext context, {required Sex? sex}) {
    if (sex == null) return '';
    late final String value;
    switch (sex) {
      case Sex.MALE:
        value = context.l10n.wich_date_you_have_reservation_male;
        break;
      case Sex.FEMALE:
        value = context.l10n.wich_date_you_have_reservation_female;
        break;
    }
    return value;
  }

  void _standardFreqTapped() => setState(() {
        _freqSelected = false;
        _standardFreqSelected = !_standardFreqSelected;
      });

  void _freqTapped() => setState(() {
        _standardFreqSelected = false;
        _freqSelected = !_freqSelected;
      });

  void _nextExamDunnoTapped(bool value) => setState(() {
        _nextExamDunno = value;
      });

  void setFrequencyExam(String value) => setState(() {
        _customInterval = value;
        // _showLastExamError = false;
      });

  void onNextExamDateSet(DateTime? dateTime) => setState(() {
        _nextExamDate = dateTime;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: LoonoColors.primaryLight50,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoonoCloseButton(onPressed: () async => _closeForm(context)),
          ),
        ],
      ),
      backgroundColor: LoonoColors.primaryLight50,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upravit prohlidku',
              style: LoonoFonts.customExamLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Frekvence prohlidek'),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, left: 13, bottom: 13),
                      child: GestureDetector(
                        onTap: _standardFreqTapped,
                        child: Row(
                          children: [
                            LoonoRadioButton(isChecked: _standardFreqSelected),
                            const SizedBox(
                              width: 22,
                            ),
                            const Text('Jednou za 2 roky (standardni)')
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, left: 13, bottom: 13),
                      child: GestureDetector(
                        onTap: _freqTapped,
                        child: Row(
                          children: [
                            LoonoRadioButton(isChecked: _freqSelected),
                            const SizedBox(
                              width: 22,
                            ),
                            const Text('Jednou za'),
                            const Spacer(),
                            SizedBox(
                              width: 160,
                              child: CustomInputTextField(
                                //356 TODO: otevreni vyberu intervalu jako SHEET
                                error: false, //356 TODO: promenna pro error
                                label: '',
                                hintText: context.l10n.exam_frequency,
                                value: _customInterval,
                                onClickInputField: () => AutoRouter.of(context).navigate(
                                  ChooseFrequencyOfExamRoute(
                                    value: _customInterval,
                                    valueChanged: setFrequencyExam,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomInputTextField(
                            error: false,
                            enabled: !_nextExamDunno,
                            label: _nextExamDate == null ? '' : context.l10n.next_examination,
                            hintText: context.l10n.next_examination,
                            value: _nextExamDate != null
                                ? DateFormat(LoonoStrings.dateWithHoursFormat)
                                    .format(_nextExamDate!)
                                : '',
                            prefixIcon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              width: 5,
                              height: 5,
                              fit: BoxFit.scaleDown,
                              color: _nextExamDunno ? Colors.black38 : Colors.black87,
                            ),
                            onClickInputField: () => AutoRouter.of(context).navigate(
                              ChooseExamPeriodDateRoute(
                                showLastExamDate: true,
                                label: _getUserLabelBySex(
                                  context,
                                  sex: _usersDao.user?.sex ?? Sex.FEMALE,
                                ),
                                pickTime: true,
                                dateTime: _nextExamDate,
                                onValueChange: onNextExamDateSet,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: CheckboxCustom(
                            text: 'Nevim',
                            isChecked: _nextExamDunno,
                            whatIsChecked: _nextExamDunnoTapped,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            LoonoButton(
              text: 'Ulozit zmeny',
              onTap: () {
                print('tap');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// date picker
// ChooseExamPeriodDateScreen(
//         onValueChange: onDateSet,
//         label: _getUserLabelBySex(context, sex: _usersDao.user?.sex ?? Sex.FEMALE),
//         pickTime: true,
//       )
