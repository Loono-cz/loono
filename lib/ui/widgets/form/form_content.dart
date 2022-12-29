import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';

import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/form/form_question_types_wrapper.dart';
import 'package:loono/ui/widgets/note_text_field.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/registry.dart';

enum QuestionTypes {
  uninitialized,
  selfExam,
  mentalHealth,
  preventionAndHealthStyle,
  heartAndVessel,
  reproductionalHealth,
  sexualHealth,
  preventiveExamAndScreening,
  other,
}

class FormContent extends StatefulWidget {
  const FormContent(
    this._questionType, {
    super.key,
  });

  final QuestionTypes _questionType;

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _currentUser = registry.get<DatabaseService>().users.user!;
  final _textFieldController = TextEditingController();
  late QuestionTypes _questionType;
  bool _wrapperError = false;
  bool _textInputError = false;

  @override
  void initState() {
    super.initState();
    _questionType = widget._questionType;
  }

  void _updateQuestionType(int index) {
    _questionType = QuestionTypes.values[index + 1];
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.form_snack_error,
          style: LoonoFonts.snackbarStyle,
        ),
        backgroundColor: LoonoColors.errorColor,
      ),
    );
  }

  void _validateFormFields() {
    setState(() {
      if (_questionType == QuestionTypes.uninitialized) {
        _wrapperError = true;
        _showErrorSnackBar();
      } else {
        _wrapperError = false;
      }
      if (_textFieldController.text.isEmpty) {
        _textInputError = true;
        _showErrorSnackBar();
      } else {
        _textInputError = false;
      }
    });
  }

  void _sendForm() {
    _validateFormFields();
    if (_questionType != QuestionTypes.uninitialized && _textFieldController.text.isNotEmpty) {
      // TODO: SEND FORM
      // final name = _currentUser.nickname!;
      // final sex = _currentUser.sex!;
      // final age = _currentUser.dateOfBirth!;
      // final message = _textFieldController.text;
      // print(name);
      // print(sex);
      // print(age);
      // print(message);
      // print(_questionType);
      AutoRouter.of(context).popUntilRoot();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.form_snack_success,
            style: LoonoFonts.snackbarStyle,
          ),
          backgroundColor: LoonoColors.greenSuccess,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.form_specialist_question,
                    textAlign: TextAlign.left,
                    style: LoonoFonts.headerFontStyle,
                  ),
                  const CustomSpacer.vertical(30),
                  Text(
                    context.l10n.form_question_answer('"${_currentUser.email!}"'),
                    style: LoonoFonts.paragraphFontStyle,
                  ),
                  const Divider(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      context.l10n.form_question_field,
                      style: LoonoFonts.subtitleFontStyle,
                    ),
                  ),
                  FormQuestionTypesWrapper(
                    _questionType.index == 0 ? null : _questionType.index - 1,
                    _updateQuestionType,
                  ),
                  if (_wrapperError)
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        context.l10n.form_wrapper_error,
                        style: LoonoFonts.errorMessageStyle,
                      ),
                    ),
                  const CustomSpacer.vertical(30),
                  noteTextField(
                    context,
                    noteController: _textFieldController,
                    onNoteChange: null,
                    maxLength: 700,
                    isForm: true,
                    error: _textInputError,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 70,
            left: 18,
            right: 18,
          ),
          child: LoonoButton(
            onTap: _sendForm,
            text: context.l10n.form_send_question,
          ),
        )
      ],
    );
  }
}
