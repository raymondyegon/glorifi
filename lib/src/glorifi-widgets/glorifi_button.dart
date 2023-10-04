import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class OnboardingButton extends StatelessWidget {
  final String btnName;
  final Callback callback;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? bgColor;

  const OnboardingButton({
    Key? key,
    required this.btnName,
    required this.callback,
    this.padding,
    this.margin,
    this.bgColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(
        onPressed: callback,
        child: Text(btnName),
        style: TextButton.styleFrom(
          padding: padding ?? const EdgeInsets.all(5.0),
          primary: Colors.white,
          backgroundColor: bgColor,
          textStyle: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
