import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/investment/widgets/text_style.dart.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(buttonText, style: textStyleButton),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),))));
  }
}
