import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

class FormQuestionTypesWrapper extends StatefulWidget {
  const FormQuestionTypesWrapper(
    this.defaultChipIndex,
    this.updateQuestionType, {
    super.key,
  });

  final Function updateQuestionType;
  final int? defaultChipIndex;

  @override
  State<FormQuestionTypesWrapper> createState() => _FormQuestionTypesWrapperState();
}

class _FormQuestionTypesWrapperState extends State<FormQuestionTypesWrapper> {
  late List<String> _choices;
  late Function _updateQuestionType;
  int? _activeChipIndex;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      _initialized = true;
      _choices = [
        context.l10n.form_self_exam,
        context.l10n.form_mentalHealth,
        context.l10n.form_preventionAndHealthStyle,
        context.l10n.form_heartAndVessel,
        context.l10n.form_reproductionalHealth,
        context.l10n.form_sexualHealth,
        context.l10n.form_preventiveExamAndScreening,
        context.l10n.form_other,
      ];
      _updateQuestionType = widget.updateQuestionType;
      _activeChipIndex = widget.defaultChipIndex;
    }
    super.didChangeDependencies();
  }

  void _updateState(bool value, int index) {
    if (value) {
      setState(() {
        _updateQuestionType(index);
        _activeChipIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(_choices.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ChoiceChip(
            avatar: null,
            label: Text(
              _choices[index],
              style: index == _activeChipIndex
                  ? LoonoFonts.chipStyleActive
                  : LoonoFonts.chipStyleDefault,
            ),
            selected: index == _activeChipIndex,
            selectedColor: LoonoColors.beigeLight,
            disabledColor: Colors.transparent,
            backgroundColor: LoonoColors.choiceChipDisable,
            onSelected: (value) {
              _updateState(value, index);
            },
          ),
        );
      }),
    );
  }
}
