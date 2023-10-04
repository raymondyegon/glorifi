import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.showIcon = false})
      : super(key: key);

  final VoidCallback onTap;
  final String title;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: GlorifiColors.darkBlueTint[700],
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: bodyBold18Primary(
                color: GlorifiColors.white,
              ),
            ),
            showIcon
                ? Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      SvgPicture.asset(GlorifiAssets.arrowForward)
                    ],
                  )
                : Offstage()
          ],
        ));
  }
}
