import 'package:flutter/material.dart';

///This widget provides a checkbox without padding
class AppCheckbox extends StatelessWidget {
  final Color activeColor;
  final Color checkColor;
  final Color uncheckedBorderColor;
  final bool initialValue;
  final Function(bool?)? onCheckChange;

  const AppCheckbox({
    Key? key,
    this.initialValue = false,
    this.uncheckedBorderColor = Colors.white,
    this.checkColor = Colors.white,
    this.activeColor = const Color(0xff8bbbda),
    this.onCheckChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: uncheckedBorderColor,
          //your desire colour here
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        checkColor: checkColor,
        activeColor: activeColor,
        value: initialValue,
        onChanged: onCheckChange,
      ),
    );
  }
}
