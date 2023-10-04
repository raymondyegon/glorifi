import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type_layout.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class GlorifiAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlorifiAppBar({
    Key? key,
    required this.title,
    this.textStyle,
    this.leading,
    this.trailing,
    this.elevation = 5,
    this.bgColor,
    this.toolbarHeight,
    this.leadingIconDefaultColor,
    this.disableLeading = false,
  }) : super(key: key);

  final String title;
  final TextStyle? textStyle;
  final Leading? leading;
  final Trailing? trailing;
  final double? elevation;
  final Color? bgColor;
  final Color? leadingIconDefaultColor;
  final bool disableLeading;

  // final bool? centerTitle;
  final double? toolbarHeight;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScreenLayout(
      mobile: AppBar(
        backgroundColor: bgColor ?? Colors.white,
        centerTitle: true,
        toolbarHeight: toolbarHeight,
        leadingWidth: leading?.text != null ? 70 : null,
        leading: !disableLeading
            ? leading?.text != null
                ? TextButton(
                    onPressed: leading?.onTap ?? Get.back,
                    child: Text(
                      "${leading?.text}",
                      style: leading?.textStyle ??
                          captionBold14Primary(
                            color: GlorifiColors.lightRed,
                          ),
                      maxLines: 1,
                    ),
                  )
                : IconButton(
                    icon: leading?.icon ??
                        SvgPicture.asset(
                          GlorifiAssets.careLeftSmall,
                          color: leadingIconDefaultColor,
                        ),
                    onPressed: leading?.onTap ?? Get.back,
                  )
            : Offstage(),
        elevation: elevation,
        title: Text(
          title,
          style: textStyle ??
              bodySemiBold18Primary(
                color: GlorifiColors.ebonyBlue,
              ),
        ),
        actions: [
          if (trailing != null)
            Container(
              margin: EdgeInsets.only(right: trailing!.rightMargin),
              child: TextButton(
                onPressed: () {
                  trailing!.onTap();
                },
                child: trailing!.text != null
                    ? Text(
                        trailing!.text!,
                        style: trailing!.textStyle ??
                            captionBold14Primary(
                              color: GlorifiColors.lightRed,
                            ),
                      )
                    : trailing!.icon!,
              ),
            )
        ],
        shadowColor: Colors.black.withOpacity(0.25),
      ),
    );
  }
}

class Leading {
  final String? text;
  final VoidCallback? onTap;
  final Widget? icon;
  final TextStyle? textStyle;

  Leading({
    this.onTap,
    this.text,
    this.icon,
    this.textStyle,
  });
}

class Trailing {
  final String? text;
  final double rightMargin;
  final Function onTap;
  final Widget? icon;
  final TextStyle? textStyle;

  Trailing({
    this.text,
    this.rightMargin = 0.0,
    this.icon,
    required this.onTap,
    this.textStyle,
  }) : assert(text != null || icon != null);
}
