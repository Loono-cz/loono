import 'package:flutter/material.dart';

import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/loono.dart';

class FormQuestionTypesWrapper extends StatefulWidget {
  const FormQuestionTypesWrapper(
    this.defaultChipIndex,
    this.updateQuestionType, {
    super.key,
  });

  final int? defaultChipIndex;
  final Function updateQuestionType;

  @override
  State<FormQuestionTypesWrapper> createState() => _FormQuestionTypesWrapperState();
}

class _FormQuestionTypesWrapperState extends State<FormQuestionTypesWrapper> {
  late List<String> choices = [
    'Samovyšetření prsou/varlat',
    'Duševní zdraví',
    'Prevence a životní styl',
    'Zdravé srdce a cévy',
    'Reprodukční zdraví',
    'Sexuální zdraví',
    'Preventivní prohlídky a screeningy',
    'Jiné',
  ];
  late Function updateQuestionType;
  int? activeChipIndex;

  @override
  void initState() {
    updateQuestionType = widget.updateQuestionType;
    activeChipIndex = widget.defaultChipIndex;
    super.initState();
  }

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
              style: index == activeChipIndex ? LoonoFonts.chipStyleActive : LoonoFonts.chipStyleDefault,
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
