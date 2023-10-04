import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

enum ButtonState {
  sDefault,
  disabled,
  focused,
  hover,
  pressed,
}

class AppButton extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Function? onTap;
  final BorderRadius? borderRadius;
  final double? height;
  final double? elevation;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  AppButton({
    Key? key,
    this.label,
    this.textColor,
    this.backgroundColor: Colors.white,
    this.borderRadius,
    required this.onTap,
    this.height: 64,
    this.fontWeight,
    this.fontSize: 16,
    this.textStyle,
    this.elevation: 3,
    this.borderColor: Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height!.h,
      child: TextButton(
        onPressed: () => onTap!(),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation!.r,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: borderColor!,
            ),
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  8.w,
                ),
          ),
        ),
        child: Center(
          child: Text(
            label!,
            style: textStyle ??
                Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
          ),
        ),
      ),
    );
  }
}

class GlorifiButton extends StatelessWidget {
  final String? label;

  final Function? onTap;
  final double? height;
  final double? width;
  final ButtonState state;
  final bool prefixIcon;
  final bool suffixIcon;

  GlorifiButton({
    Key? key,
    this.label,
    required this.onTap,
    this.height: 64,
    this.width,
    this.state: ButtonState.sDefault,
    this.prefixIcon: false,
    this.suffixIcon: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => state == ButtonState.disabled ? null : onTap!(),
      child: Container(
        height: height!.h,
        width:
            width != null ? width!.w : MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          border: Border.all(
            color: getColor()!,
          ),
          color: getColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon == true
                ? Icon(
                    Icons.arrow_back,
                    color: GlorifiColors.white,
                  )
                : Container(),
            SizedBox(
              width: 12.w,
            ),
            Text(
              label!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: GlorifiColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
            ),
            SizedBox(
              width: 12.w,
            ),
            suffixIcon == true
                ? Icon(
                    Icons.arrow_forward,
                    color: GlorifiColors.white,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  getColor() {
    Color backgroundColor = Colors.transparent;
    switch (state) {
      case ButtonState.sDefault:
        backgroundColor = GlorifiColors.darkOrange;
        break;
      case ButtonState.disabled:
        backgroundColor = GlorifiColors.greyBgColor;
        break;
      case ButtonState.focused:
        backgroundColor = GlorifiColors.bloodOrange;
        break;
      case ButtonState.hover:
        backgroundColor = GlorifiColors.red;
        break;
      case ButtonState.pressed:
        backgroundColor = GlorifiColors.red;
        break;
    }
    return backgroundColor;
  }
}
