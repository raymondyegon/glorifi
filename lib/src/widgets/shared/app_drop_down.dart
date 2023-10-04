import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../font_style_global.dart';

class AppDropDownList extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final dynamic value;
  final double? height;
  final double? width;
  final Function? onChanged;
  final TextStyle? labelTextStyle;
  final Color? borderColor;
  final double? borderWidth;
  final String? hintText;

  AppDropDownList({
    Key? key,
    required this.items,
    this.onChanged,
    this.value,
    this.labelTextStyle,
    this.height: 26,
    this.width: double.infinity,
    this.borderWidth: 1.0,
    this.borderColor = Colors.transparent,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!.h,
      width: width!.w,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(
          color: borderColor!,
        ),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<dynamic>(
        isExpanded: true,
        elevation: 1,
        isDense: true,
        value: value,
        items: items,
        hint: Text(hintText!),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: smallRegular16Primary(),
          border: InputBorder.none,
        ),
        icon: Padding(
          padding: EdgeInsets.only(
            right: 8.w,
          ),
          child: Icon(
            Icons.expand_more,
            size: 32.w,
          ),
        ),
        onChanged: (v) => onChanged!(v),
      ),
    );
  }
}
