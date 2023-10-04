import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../font_style_global.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? side;
  final Function? onTap;
  final BorderRadius? borderRadius;
  final double? height;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  AppButton({
    Key? key,
    this.label,
    this.textColor,
    this.backgroundColor: GlorifiColors.white,
    this.side: const BorderSide(style: BorderStyle.none),
    this.borderRadius,
    required this.onTap,
    this.height: 64,
    this.fontWeight,
    this.fontSize: 16,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: () => onTap!(),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            side: side!,
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  4.sp,
                ),
          ),
        ),
        child: Center(
          child: Text(
            label!,
            style: textStyle ??
                Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                    ),
          ),
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Function? onTap;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;

  final Widget? prefixWidget;

  AppIconButton({
    Key? key,
    this.label,
    this.backgroundColor,
    this.textColor,
    required this.onTap,
    this.height: 20,
    this.fontWeight,
    this.prefixWidget,
    this.width: 32,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Card(
        child: Container(
          height: height!.h,
          width: width!.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor!,
            ),
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.w,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                prefixWidget!,
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: smallRegular16Primary(
                    color: textColor,
                  ).copyWith(
                    fontWeight: fontWeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
