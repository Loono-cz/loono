import 'package:flutter/material.dart';

import 'package:loono/constants.dart';

class FormQuestionTypesWrapper extends StatefulWidget {
  const FormQuestionTypesWrapper(this.updateQuestionType, {super.key,});

  final Function updateQuestionType;

  @override
  State<FormQuestionTypesWrapper> createState() => _FormQuestionTypesWrapperState(updateQuestionType);
}

class _FormQuestionTypesWrapperState extends State<FormQuestionTypesWrapper> {
  _FormQuestionTypesWrapperState(this.updateQuestionType);
  Function updateQuestionType;
  final List<String> choices = [
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

  void updateState(bool value, int index) {
    if (value) {
      setState(() {
        updateQuestionType(index);
        activeChipIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(choices.length, (index) {
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
              choices[index],
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
    );
  }
}
