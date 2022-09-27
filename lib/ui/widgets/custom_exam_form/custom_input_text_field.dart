import 'package:flutter/material.dart';

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
  });
  final String label;
  final String? hintText;
  final Widget? prefixIcon;
  final String value;
  final VoidCallback? onClickInputField;
  final bool? enabled;
  final bool error;
  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  var textController = TextEditingController();

  final disabledFieldBorder =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black38));

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
      decoration: InputDecoration(
        disabledBorder: widget.enabled == false ? disabledFieldBorder : textFieldBorder,
        errorBorder: widget.error
            ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
            : widget.enabled == false
                ? disabledFieldBorder
                : textFieldBorder,
        suffixIcon: widget.prefixIcon != null
            ? null
            : const Icon(
                Icons.arrow_downward_outlined,
              ),
        errorText: widget.error ? 'Toto pole je povinné' : '',
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
