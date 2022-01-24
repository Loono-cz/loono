import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';

typedef SubmitCallback = void Function(String input);

class FallbackAccountContent extends StatefulWidget {
  const FallbackAccountContent({
    Key? key,
    this.appBar,
    this.backgroundColor,
    this.title = '',
    this.initialText,
    this.hint,
    this.description = '',
    this.validator,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.onSubmit,
    this.buttonText,
    this.filled,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final String title;
  final String? initialText;
  final String? hint;
  final String description;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final String? buttonText;
  final bool? filled;

  /// Called whenever the text changes in the [TextFormField].
  final ValueChanged<String>? onChanged;

  /// Callback is called on Button click or onFieldSubmitted from keyboard,
  /// if the user input is valid.
  final SubmitCallback? onSubmit;

  @override
  _FallbackAccountContentState createState() => _FallbackAccountContentState();
}

class _FallbackAccountContentState extends State<FallbackAccountContent> {
  late final TextEditingController _textEditingController;
  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit?.call(_textEditingController.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 118.0),
              _buildTitle(),
              const SizedBox(height: 19.0),
              _buildForm(),
              if (widget.description.isNotEmpty) ..._buildDescription(),
              const Spacer(),
              LoonoButton(
                text: widget.buttonText ?? context.l10n.confirm_info,
                onTap: validateAndSubmit,
              ),
              const SizedBox(height: 18.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: LoonoColors.black, fontSize: 16.0),
      ),
    );
  }

  List<Widget> _buildDescription() {
    return <Widget>[
      const SizedBox(height: 40.0),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.only(right: 57.0),
          child: Text(
            widget.description,
            style: const TextStyle(
              color: LoonoColors.black,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _textEditingController,
        onFieldSubmitted: (_) => validateAndSubmit(),
        onChanged: widget.onChanged,
        cursorColor: LoonoColors.black,
        style: const TextStyle(fontSize: 24.0, color: LoonoColors.black),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 24.0, color: LoonoColors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: LoonoColors.primaryEnabled,
              width: widget.filled == true ? 4.0 : 2.0,
            ),
            borderRadius: widget.filled == true
                ? const BorderRadius.all(Radius.circular(10.0))
                : const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
          ),
          filled: widget.filled,
          fillColor: widget.filled == true ? Colors.white : null,
        ),
        autofocus: true,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
