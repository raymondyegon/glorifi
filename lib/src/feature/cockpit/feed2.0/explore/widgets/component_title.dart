import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ComponentTitle extends StatelessWidget {
  const ComponentTitle(
      {Key? key, required this.title, this.subTitle, this.showSubTitle = true})
      : super(key: key);

  final String title;
  final String? subTitle;
  final bool showSubTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: leadRegular24Secondary(color: GlorifiColors.cornflowerBlue),
        ),
        if (showSubTitle)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  subTitle!,
                  style: captionSemiBold14Primary(color: GlorifiColors.darkGrey)
                      .copyWith(height: 1.5),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
