import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class PrimaryDarkButton extends PrimaryButton {
  const PrimaryDarkButton({
    Key? key,
    required String title,
    double? width = double.infinity,
    double height = GlorifiValues.defaultButtonHeight,
    Color primaryColor = GlorifiColors.primaryDarkButtonColor,
    double fontSize = GlorifiValues.defaultButtonTextSize,
    Color textColor = GlorifiColors.primaryDarkButtonTextColor,
    double iconSpacing = GlorifiValues.margin_4,
    Color splashColor = GlorifiColors.primaryDarkButtonSplashColor,
    Color progressBarColor = GlorifiColors.primaryDarkButtonSplashColor,
    Color iconColor = GlorifiColors.lightBlue,
    bool hasLeftArrow = false,
    bool hasRightArrow = false,
    bool isLoading = false,
    bool avoidShadow = false,
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
          avoidShadow: avoidShadow,
          width: width,
          enabled: enabled,
        );
}
