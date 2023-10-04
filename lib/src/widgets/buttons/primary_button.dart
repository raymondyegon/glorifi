import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_button.dart';

///Primary button to use across the app
///[title] button text
///[width] button width - default is max screen size [double.infinity]
///[height] button height - default is [GlorifiValues.defaultButtonHeight]
///[primaryColor] button primary color -sets the button background
///[fontSize] button text font size
///[textColor] button text's color
///[iconSpacing] space/margin between [icon] and text
///[splashColor] splash/ripple color
///[progressBarColor] if [isLoading] is true, this shows a progress
///bar inside the button, this property set's the color
///[hasLeftArrow] adds a arrow icon to left
///[hasRightArrow] adds a arrow icon to left
///[isLoading] set's the state of is button show text/loading indicator
///[icon] any [Widget] can be used as a icon next to the text
///[onTap] function to trigger when user press a button
class PrimaryButton extends GlorifiButton {
  const PrimaryButton({
    Key? key,
    required String title,
    double? width = double.infinity,
    double height = GlorifiValues.defaultButtonHeight,
    Color primaryColor = GlorifiColors.primaryButtonColor,
    double fontSize = GlorifiValues.defaultButtonTextSize,
    Color textColor = GlorifiColors.primaryButtonTextColor,
    double iconSpacing = GlorifiValues.margin_4,
    Color splashColor = GlorifiColors.primaryButtonSplashColor,
    Color progressBarColor = GlorifiColors.primaryButtonProgressColor,
    Color iconColor = GlorifiColors.primaryButtonIconColor,
    bool hasLeftArrow = false,
    bool hasRightArrow = false,
    bool avoidShadow = false,
    bool isLoading = false,
    Widget? icon,
    Function()? onTap,
    bool enabled = true,
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
          enabled: enabled,
          avoidShadow: avoidShadow,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        style: avoidShadow
            ? ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                primary: primaryColor,
                onPrimary: splashColor,
                elevation: 0.0,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: GlorifiValues.padding,
                  vertical: GlorifiValues.extraSmallPadding,
                ),
              )
            : ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GlorifiValues.radius_6),
                ),
                primary: primaryColor,
                onPrimary: splashColor,
                padding: EdgeInsets.symmetric(
                  horizontal: GlorifiValues.padding,
                  vertical: GlorifiValues.extraSmallPadding,
                ),
              ),
        child: isLoading
            ? CircularProgressIndicator(
                color: progressBarColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(width: hasRightArrow ? iconSpacing : 0),
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
        onPressed: enabled ? (isLoading ? () {} : onTap ?? () {}) : null,
      ),
    );
  }
}
