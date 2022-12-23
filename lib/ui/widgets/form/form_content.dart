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
    this.questionType, {
    super.key,
  });

  final QuestionTypes questionType;

  @override
  State<FormContent> createState() => _FormContentState(
        questionType,
      );
}

class _FormContentState extends State<FormContent> {
  _FormContentState(
    this.questionType,
  );

  final _currentUser = registry.get<DatabaseService>().users.user!;
  final _textFieldController = TextEditingController();
  QuestionTypes questionType;
  bool wrapperError = false;
  bool textInputError = false;

  void updateQuestionType(int index) {
    questionType = QuestionTypes.values[index + 1];
  }

  void showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.form_snack_error,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: LoonoColors.errorColor,
      ),
    );
  }

  void sendForm() {
    setState(() {
      if (questionType == QuestionTypes.uninitialized) {
        wrapperError = true;
        showErrorSnackBar();
      } else {
        wrapperError = false;
      }
      if (_textFieldController.text.isEmpty) {
        textInputError = true;
        showErrorSnackBar();
      } else {
        textInputError = false;
      }

      if (questionType != QuestionTypes.uninitialized && _textFieldController.text.isNotEmpty) {
        // TODO: SEND FORM
        AutoRouter.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.form_snack_success,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: LoonoColors.greenSuccess,
          ),
        );
      }
    });
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const CustomSpacer.vertical(30),
                  Text(
                    context.l10n.form_question_answer('"${_currentUser.email!}"'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      context.l10n.form_question_field,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FormQuestionTypesWrapper(
                    questionType.index == 0 ? null : questionType.index - 1,
                    updateQuestionType,
                  ),
                  if (wrapperError)
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        context.l10n.form_wrapper_error,
                        style: const TextStyle(
                          color: LoonoColors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  const CustomSpacer.vertical(30),
                  noteTextField(
                    context,
                    noteController: _textFieldController,
                    onNoteChange: null,
                    maxLength: 700,
                    isForm: true,
                    error: textInputError,
                    errorText: context.l10n.form_input_error,
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
            onTap: sendForm,
            text: context.l10n.form_send_question,
          ),
        )
      ],
    );
  }
}
