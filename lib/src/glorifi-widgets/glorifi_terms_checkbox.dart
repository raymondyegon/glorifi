import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class GlorifiCheckbox extends StatefulWidget {
  final Color? activeColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final double margin;
  final void Function(bool ischecked) onPressed;

  const GlorifiCheckbox(
      {Key? key,
      this.activeColor,
      this.checkColor,
      this.focusColor,
      this.hoverColor,
      this.margin = 8,
      required this.onPressed})
      : super(key: key);

  @override
  _GlorifiCheckboxState createState() => _GlorifiCheckboxState();
}

class _GlorifiCheckboxState extends State<GlorifiCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: widget.margin.h, horizontal: widget.margin.w),
        decoration: BoxDecoration(
            color: isChecked ? widget.checkColor : Colors.transparent,
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(
              color: Colors.black,
              width: 2.w,
            )),
        width: 18.w,
        height: 18.h,
        child: isChecked
            ? Icon(
                Icons.check,
                color: widget.activeColor,
                size: 14.w,
              )
            : null,
      ),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onPressed(isChecked);
        });
      },
    );
  }
}
