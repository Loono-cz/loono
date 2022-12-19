import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

Widget noteTextField(
  BuildContext context, {
  required TextEditingController noteController,
  bool? enable = true,
  required void Function(String)? onNoteChange,
  FocusNode? focusNode,
  int maxLength = 256,
}) {
  return TextFormField(
    controller: noteController,
    minLines: 5,
    maxLines: 10,
    maxLength: maxLength,
    keyboardType: TextInputType.multiline,
    enabled: enable,
    focusNode: focusNode,
    onChanged: onNoteChange,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: context.l10n.note_visiting_description,
      label: noteController.text.isEmpty ? null : Text(context.l10n.note_visiting),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: LoonoColors.primaryEnabled),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  );
}
