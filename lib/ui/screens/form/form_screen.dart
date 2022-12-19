import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/note_text_field.dart';
import 'package:loono/ui/widgets/space.dart';

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
  final _textFieldController = TextEditingController();
  int? defaultIndex;
  final QuestionTypes questionType = QuestionTypes.uninitialized;
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

  void updateState(bool value, int index) {
    setState(() {
      defaultIndex = value ? index : defaultIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        context.l10n.form_question_answer('"user e-mail address"'),
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
                              avatar: index == defaultIndex
                                  ? const Icon(
                                      Icons.check,
                                      color: LoonoColors.primaryEnabled,
                                    )
                                  : null,
                              label: Text(
                                _choices[index],
                                style: TextStyle(
                                  color: index == defaultIndex
                                      ? LoonoColors.primaryEnabled
                                      : LoonoColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              selected: index == defaultIndex,
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
                text: 'Odeslat dotaz',
              ),
            )
          ],
        ),
      ),
    );
  }
}
