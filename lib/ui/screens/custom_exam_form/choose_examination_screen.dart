import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_action_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_radio_button.dart';
import 'package:loono_api/loono_api.dart';

class ChooseCustomExaminationTypeScreen extends StatefulWidget {
  const ChooseCustomExaminationTypeScreen({
    this.actionType,
    required this.onActionTypeSet,
    super.key,
  });
  final ExaminationActionType? actionType;
  final Function(ExaminationActionType?) onActionTypeSet;
  @override
  State<ChooseCustomExaminationTypeScreen> createState() =>
      _ChooseCustomExaminationTypeScreenState();
}

class _ChooseCustomExaminationTypeScreenState extends State<ChooseCustomExaminationTypeScreen> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();

  String? _groupValue = '';
  ExaminationActionType? _examActionType;
  @override
  void initState() {
    super.initState();
    setState(() {
      _groupValue = widget.actionType != null
          ? ExaminationActionTypeExt(widget.actionType!).l10n_name.toString()
          : '';
      _examActionType = widget.actionType;
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
              context.l10n.custom_exam_type_question,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              thickness: 1.0,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ExaminationActionType.values.length,
                  itemBuilder: ((context, index) {
                    final actionType = ExaminationActionType.values.toList()[index];

                    return Column(
                      children: [
                        CustomRadioButton(
                          text: actionType.l10n_name,
                          isChecked: actionType.l10n_name == _groupValue,
                          whatIsChecked: (checked) => setState(() {
                            _groupValue = actionType.l10n_name;
                            _examActionType = actionType;
                          }),
                        ),
                        const Divider(
                          thickness: 1.0,
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            LoonoButton(
              text: context.l10n.confirm_info,
              onTap: () {
                widget.onActionTypeSet(_examActionType);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
