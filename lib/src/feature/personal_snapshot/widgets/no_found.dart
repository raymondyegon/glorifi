import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';

class NoFound extends StatelessWidget {
  const NoFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 52.h),
      height: 64.h,
      decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 18),
            child: SvgPicture.asset(
              GlorifiAssets.alertCircle,
              color: GlorifiColors.redError,
              width: 24.w,
              height: 24.h,
            ),
          ),
          Expanded(
            child: Text(
              'No data found. Try a different address. ',
              style: xSmallRegular12Primary(color: GlorifiColors.ebonyBlue),
            ),
          ),
        ],
      ),
    );
  }
}
