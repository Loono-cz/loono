import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
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

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _currentUser = registry.get<DatabaseService>().users.user!;
  final _textFieldController = TextEditingController();
  final List<String> _choices = [
    'Samovyšetření prsou/varlat',
    'Duševní zdraví',
    'Prevence a životní styl',
    'Zdravé srdce a cévy',
    'Reprodukční zdraví',
    'Sexuální zdraví',
    'Preventivní prohlídky a screeningy',
    'Jiné',
  ];

  int? activeChipIndex;
  QuestionTypes questionType = QuestionTypes.uninitialized;

  void updateState(bool value, int index) {
    if (value) {
      setState(() {
        questionType = QuestionTypes.values[index + 1];
        activeChipIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // print(questionType);
    // print(activeChipIndex);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            AutoRouter.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
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
                        ),
                      ),
                      Wrap(
                        children: List.generate(_choices.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              avatar: index == activeChipIndex
                                  ? const Icon(
                                      Icons.check,
                                      color: LoonoColors.primaryEnabled,
                                    )
                                  : null,
                              label: Text(
                                _choices[index],
                                style: TextStyle(
                                  color: index == activeChipIndex
                                      ? LoonoColors.primaryEnabled
                                      : LoonoColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              selected: index == activeChipIndex,
                              selectedColor: LoonoColors.beigeLight,
                              onSelected: (value) {
                                updateState(value, index);
                              },
                            ),
                          );
                        }),
                      ),
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
        ),
      ),
    );
  }
}
