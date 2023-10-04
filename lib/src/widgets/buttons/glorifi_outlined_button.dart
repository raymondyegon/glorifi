import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_button.dart';

class GlorifiOutlinedButton extends GlorifiButton {
  final Color borderColor;
  final double borderWidth;

  const GlorifiOutlinedButton({
    Key? key,
    required String title,
    double width = double.infinity,
    double height = GlorifiValues.defaultButtonHeight,
    Color primaryColor = GlorifiColors.white,
    double fontSize = GlorifiValues.defaultButtonTextSize,
    Color textColor = GlorifiColors.outlineButtonTextColor,
    double iconSpacing = GlorifiValues.margin_4,
    Color splashColor = GlorifiColors.primaryButtonSplashColor,
    Color progressBarColor = GlorifiColors.midnightBlue,
    Color iconColor = GlorifiColors.black,
    bool hasLeftArrow = false,
    bool hasRightArrow = false,
    bool isLoading = false,
    Widget? icon,
    Function()? onTap,
    this.borderColor = GlorifiColors.black,
    this.borderWidth = GlorifiValues.defaultButtonBorderWidth,
  }) : super(
          key: key,
          title: title,
          fontSize: fontSize,
          textColor: textColor,
          primaryColor: primaryColor,
          height: height,
          hasLeftArrow: hasLeftArrow,
          hasRightArrow: hasRightArrow,
          icon: icon,
          iconColor: iconColor,
          iconSpacing: iconSpacing,
          isLoading: isLoading,
          onTap: onTap,
          progressBarColor: progressBarColor,
          splashColor: splashColor,
          width: width,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: primaryColor,
              side: BorderSide(color: borderColor, width: borderWidth),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GlorifiValues.radius_6)),
              primary: splashColor,
              padding: EdgeInsets.symmetric(
                horizontal: GlorifiValues.padding,
                vertical: GlorifiValues.extraSmallPadding,
              )),
          child: isLoading
              ? CircularProgressIndicator(
                  color: progressBarColor,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    hasLeftArrow
                        ? Icon(
                            Icons.arrow_back,
                            size: fontSize,
                            color: iconColor,
                          )
                        : Container(),
                    SizedBox(width: hasLeftArrow ? iconSpacing : 0),
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: iconSpacing),
                    hasRightArrow
                        ? Icon(
                            Icons.arrow_forward,
                            size: fontSize,
                            color: iconColor,
                          )
                        : Container(),
                    icon ?? Container(),
                  ],
                ),
          onPressed: isLoading ? () {} : onTap,
        ));
  }
}
