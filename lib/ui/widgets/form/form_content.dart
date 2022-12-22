import 'package:flutter/material.dart';

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
  const FormContent({super.key});

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _currentUser = registry.get<DatabaseService>().users.user!;
  final _textFieldController = TextEditingController();
  QuestionTypes questionType = QuestionTypes.uninitialized;

  void updateQuestionType(int index) {
    questionType = QuestionTypes.values[index + 1];
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
                    FormQuestionTypesWrapper(updateQuestionType),
                    const CustomSpacer.vertical(30),
                    noteTextField(
                      context,
                      noteController: _textFieldController,
                      onNoteChange: null,
                      maxLength: 700,
                      isForm: true,
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
              onTap: () {},
              text: context.l10n.form_send_question,
            ),
          )
        ],
      );
  }
}
