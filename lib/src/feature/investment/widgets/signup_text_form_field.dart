import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/investment/widgets/text_field_border.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';

class SignUpTextFormField extends StatelessWidget {
  const SignUpTextFormField({
    Key? key,
    this.autoFocus,
    this.isPassword,
    required this.textInputAction,
    required this.hint,
    required this.controller,
    this.validator,
    this.textInputType,
  }) : super(key: key);

  final bool? autoFocus;
  final bool? isPassword;
  final TextInputAction textInputAction;
  final String hint;
  final TextEditingController controller;
  final validator;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      textInputAction: textInputAction,
      style: textStyleTextFieldText,
      validator: validator,
      obscureText: isPassword ?? false,
      controller: controller,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: textStyleTextField,
        fillColor: Colors.transparent,
        enabledBorder: normalBorder(),
        contentPadding: EdgeInsets.all(8),
        border: normalBorder(),
        focusedBorder: activeBorder(),
        errorBorder: errorBorder(),
      ),
    );
  }
}
