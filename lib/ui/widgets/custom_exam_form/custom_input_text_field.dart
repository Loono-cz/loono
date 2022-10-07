import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/l10n/ext.dart';

// ignore: must_be_immutable
class CustomInputTextField extends StatefulWidget {
  const CustomInputTextField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    required this.value,
    required this.onClickInputField,
    this.enabled,
    required this.error,
    this.onValidation,
  });
  final String label;
  final String? hintText;
  final Widget? prefixIcon;
  final String value;
  final VoidCallback? onClickInputField;
  final bool? enabled;
  final bool error;
  final String? Function(String?)? onValidation;

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  var textController = TextEditingController();

  final disabledFieldBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black38),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );

  final textFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black45),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        textController.text = widget.value != '' ? widget.value : widget.hintText ?? '';
      });
    });

    return TextFormField(
      style: TextStyle(color: widget.value == '' ? Colors.black38 : Colors.black, fontSize: 14),
      controller: textController,
      readOnly: true,
      enabled: widget.enabled,
      autofocus: false,
      onTap: widget.onClickInputField,
      validator: widget.onValidation,
      decoration: InputDecoration(
        disabledBorder: widget.enabled == false ? disabledFieldBorder : textFieldBorder,
        errorBorder: widget.error
            ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
            : widget.enabled == false
                ? disabledFieldBorder
                : textFieldBorder,
        suffixIcon: widget.prefixIcon != null
            ? null
            : SvgPicture.asset(
                'assets/icons/chevron_down.svg',
                width: 5,
                height: 5,
                fit: BoxFit.scaleDown,
                color: Colors.black87,
              ),
        errorText: widget.error ? context.l10n.mandatory_field : '',
        prefixIcon: widget.prefixIcon,
        suffixIconColor: Colors.black87,
        filled: true,
        fillColor: Colors.white,
        floatingLabelStyle: const TextStyle(color: Colors.black),
        focusedBorder: textFieldBorder,
        focusedErrorBorder: widget.error
            ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
            : textFieldBorder,
        border: textFieldBorder,
        enabledBorder: textFieldBorder,
        labelText: widget.label,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}
