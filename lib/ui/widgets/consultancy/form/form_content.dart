import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/consultancy/form/form_question_types_wrapper.dart';
import 'package:loono/ui/widgets/note_text_field.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/registry.dart';

enum FormQuestionType {
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

  final FormQuestionType questionType;

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final _apiService = registry.get<ApiService>();

  final _currentUser = registry.get<DatabaseService>().users.user;
  final _textFieldController = TextEditingController();
  late FormQuestionType _questionType;
  bool _wrapperError = false;
  bool _textInputError = false;

  @override
  void initState() {
    super.initState();
    _questionType = widget.questionType;
  }

  void _updateQuestionType(int index) {
    _questionType = FormQuestionType.values[index + 1];
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
      if (_questionType == FormQuestionType.uninitialized) {
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

  Future<bool?> _sendData(Map<FormQuestionType, String> formQuestionForBE) async {
    _validateFormFields();
    if (_questionType != FormQuestionType.uninitialized && _textFieldController.text.isNotEmpty) {
      final response = await _apiService.sendConsultancyForm(
        tag: formQuestionForBE[_questionType] ?? "Other",
        message: _textFieldController.text,
      );
      return response ? Future.value(true) : Future.value(false);
    }
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    var formQuestionForBE = getFormQuestionTypeForBE(context);
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
                    style: LoonoFonts.headerFontStyle,
                  ),
                  const CustomSpacer.vertical(30),
                  Text(
                    context.l10n.form_question_answer('"${_currentUser?.email}"'),
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
          child: AsyncLoonoButton(
            text: context.l10n.form_send_question,
            asyncCallback: () async {
              return _sendData(formQuestionForBE);
            },
            onSuccess: () {
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
            },
            onError: () => showFlushBarError(context, context.l10n.something_went_wrong),
          ),
        )
      ],
    );
  }

  Map<FormQuestionType, String> getFormQuestionTypeForBE(BuildContext context) {
    final map = <FormQuestionType, String>{
      FormQuestionType.selfExam: context.l10n.form_self_exam,
      FormQuestionType.mentalHealth: context.l10n.form_mentalHealth,
      FormQuestionType.preventionAndHealthStyle: context.l10n.form_preventionAndHealthStyle,
      FormQuestionType.heartAndVessel: context.l10n.form_heartAndVessel,
      FormQuestionType.reproductionalHealth: context.l10n.form_reproductionalHealth,
      FormQuestionType.sexualHealth: context.l10n.form_sexualHealth,
      FormQuestionType.preventiveExamAndScreening: context.l10n.form_preventiveExamAndScreening,
      FormQuestionType.other: context.l10n.form_other,
    };
    return map;
  }
}
