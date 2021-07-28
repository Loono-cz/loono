import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

typedef SubmitCallback = void Function(String input);

class FallbackAccountContent extends StatefulWidget {
  const FallbackAccountContent({
    Key? key,
    this.title = '',
    this.hint,
    this.description = '',
    this.validator,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.onSubmit,
  }) : super(key: key);

  final String title;
  final String? hint;
  final String description;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;

  /// Called whenever the text changes in the [TextFormField].
  final ValueChanged<String>? onChanged;

  /// Callback is called on Button click or onFieldSubmitted from keyboard,
  /// if the user input is valid.
  final SubmitCallback? onSubmit;

  @override
  _FallbackAccountContentState createState() => _FallbackAccountContentState();
}

class _FallbackAccountContentState extends State<FallbackAccountContent> {
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit?.call(_textEditingController.text);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildButton(context),
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
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: LoonoColors.black),
          ),
        ),
        autofocus: true,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ExtendedInkWell(
      onTap: validateAndSubmit,
      materialColor: LoonoColors.primaryEnabled,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: SizedBox(
        height: 65,
        child: Align(
          child: Text(
            context.l10n.confirm_info,
            style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
