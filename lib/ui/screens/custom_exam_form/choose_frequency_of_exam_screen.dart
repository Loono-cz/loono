import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_periodical_spinner.dart';
import 'package:loono_api/loono_api.dart';

enum FrequencyType { numbers, period }

class ChooseFrequencyOfExamScreen extends StatefulWidget {
  const ChooseFrequencyOfExamScreen({
    super.key,
    this.value,
    required this.valueChanged,
    this.isDefaultExam = false,
    this.examType,
  });
  final Function(String) valueChanged;
  final String? value;

  final bool isDefaultExam;
  final ExaminationType? examType;

  @override
  State<ChooseFrequencyOfExamScreen> createState() => _ChooseFrequencyOfExamScreenState();
}

class _ChooseFrequencyOfExamScreenState extends State<ChooseFrequencyOfExamScreen> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();
  String period = '';
  String numberPeriod = '';
  String stringPeriod = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.value!.isNotEmpty) {
        final str = widget.value?.split(' ');
        if (str != null) {
          numberPeriod = str[0];
          stringPeriod = str[1];
        }
      }
    });
  }

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
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.how_often_are_you_visiting,
              style: LoonoFonts.customExamLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              context.l10n.minimal_frequency_for_visiting_in_month,
              style: LoonoFonts.customExamSubLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: CustomPeriodicalSpinner(
                  isDefaultExam: widget.isDefaultExam,
                  examType: widget.examType,
                  valueChanged: (number, text) {
                    setState(() {
                      final isMonth = text.isNotEmpty && text == 'měsíce';
                      period =
                          '${number.isEmpty ? isMonth ? 6 : 1 : number} ${text.isEmpty ? 'měsíce' : text}';
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            LoonoButton(
              text: context.l10n.confirm_info,
              onTap: () {
                widget.valueChanged(period.isEmpty ? '6 měsíce' : period);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
