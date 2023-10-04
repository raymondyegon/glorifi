import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ACCReactiveBox extends StatelessWidget {
  const ACCReactiveBox({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        height: 64.h,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Text(
          title,
          style: smallSemiBold16Primary(
            color: GlorifiColors.cornflowerBlue,
          ),
        ),
      ),
    );
  }
}
