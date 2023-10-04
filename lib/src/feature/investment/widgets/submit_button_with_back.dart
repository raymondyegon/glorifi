import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/widgets/submit_button.dart';

class SubmitButtonWithBack extends StatelessWidget {
  const SubmitButtonWithBack(
      {Key? key, required this.onTap, required this.buttonText})
      : super(key: key);

  final VoidCallback onTap;
  final buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: Get.back,
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20,
        ),
      ),
      SubmitButton(buttonText: buttonText, onTap: onTap)
    ]);
  }
}
