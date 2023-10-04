import 'package:flutter/material.dart';

///This is a widget that is used for input suffix icons
///This widget places all the widget one after another in a row
class InputSuffixIcons extends StatelessWidget {
  final List<Widget> suffixIcons;
  const InputSuffixIcons({Key? key, required this.suffixIcons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: suffixIcons,
    );
  }
}
