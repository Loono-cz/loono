import 'package:flutter/material.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/custom_exam_form/custom_input_text_field.dart';

Widget chooseExamFrequency(
  BuildContext context,
  String frequency, {
  required void Function()? onClickInputField,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.ideographic,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(context.l10n.once_to),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Flexible(
        flex: 2,
        child: CustomInputTextField(
          error: false,
          label: '',
          hintText: context.l10n.exam_frequency,
          value: frequency,
          onClickInputField: onClickInputField,
        ),
      ),
    ],
  );
}
