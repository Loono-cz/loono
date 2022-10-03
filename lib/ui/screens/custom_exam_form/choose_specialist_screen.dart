import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_radio_button.dart';
import 'package:loono_api/loono_api.dart';

class ChooseSpecialistScreen extends StatefulWidget {
  const ChooseSpecialistScreen({this.specialist, required this.onProviderSet, super.key});
  final ExaminationType? specialist;
  final Function(ExaminationType?) onProviderSet;
  @override
  State<ChooseSpecialistScreen> createState() => _ChooseSpecialistScreenState();
}

class _ChooseSpecialistScreenState extends State<ChooseSpecialistScreen> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();

  String? _groupValue = '';
  final List<ExaminationType> _exams = ExaminationType.values.toList();
  ExaminationType? _examType;
  @override
  void initState() {
    super.initState();
    setState(() {
      _groupValue = widget.specialist?.l10n_name;
      _examType = widget.specialist;
    });
    _exams.sort(((a, b) => a.l10n_name.compareTo(b.l10n_name)));
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
              context.l10n.custom_exam_choose_provider,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _exams.length,
                  itemBuilder: ((context, index) {
                    final provider = _exams[index];

                    return Column(
                      children: [
                        CustomRadioButton(
                          text: provider.getName(context),
                          isChecked: provider.getName(context) == _groupValue,
                          whatIsChecked: (checked) => setState(() {
                            _groupValue = provider.getName(context);
                            _examType = provider;
                          }),
                        ),
                        const Divider()
                      ],
                    );
                  }),
                ),
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: context.l10n.custom_exam_choosen_provider),
                  TextSpan(
                    text: _groupValue,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            LoonoButton(
              text: context.l10n.confirm_info,
              onTap: () {
                widget.onProviderSet(
                  _examType,
                );
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
