import 'package:flutter/cupertino.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

abstract class GlorifiButton extends StatelessWidget {
  final String title;
  final double? width;
  final double height;
  final Color primaryColor;
  final double fontSize;
  final Color textColor;
  final double iconSpacing;
  final Color splashColor;
  final Color progressBarColor;
  final bool hasRightArrow;
  final bool hasLeftArrow;
  final bool avoidShadow;
  final bool isLoading;
  final Widget? icon;
  final Color iconColor;
  final Function()? onTap;
  final bool enabled;

  const GlorifiButton({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = GlorifiValues.defaultButtonHeight,
    this.primaryColor = GlorifiColors.primaryButtonColor,
    this.fontSize = GlorifiValues.defaultButtonTextSize,
    this.textColor = GlorifiColors.primaryDarkButtonTextColor,
    this.iconSpacing = GlorifiValues.margin_4,
    this.splashColor = GlorifiColors.primaryButtonSplashColor,
    this.progressBarColor = GlorifiColors.primaryButtonSplashColor,
    this.iconColor = GlorifiColors.primaryButtonIconColor,
    this.hasLeftArrow = false,
    this.hasRightArrow = false,
    this.isLoading = false,
    this.icon,
    this.onTap,
    this.enabled = true,
    this.avoidShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
