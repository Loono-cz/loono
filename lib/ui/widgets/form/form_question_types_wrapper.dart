import 'package:flutter/material.dart';

import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

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
  late List<String> choices;
  late Function updateQuestionType;
  int? activeChipIndex;
  bool initialized = false;

  @override
  void initState() {
    initialized = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(initialized){
      choices = [
        context.l10n.form_self_exam,
        context.l10n.form_mentalHealth,
        context.l10n.form_preventionAndHealthStyle,
        context.l10n.form_heartAndVessel,
        context.l10n.form_reproductionalHealth,
        context.l10n.form_sexualHealth,
        context.l10n.form_preventiveExamAndScreening,
        context.l10n.form_other,
      ];
      updateQuestionType = widget.updateQuestionType;
      activeChipIndex = widget.defaultChipIndex;
    }
    super.didChangeDependencies();
  }

  void _updateState(bool value, int index) {
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
              _updateState(value, index);
            },
          ),
        );
      }),
    );
  }
}
