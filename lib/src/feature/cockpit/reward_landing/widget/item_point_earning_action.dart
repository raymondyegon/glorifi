import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ItemPointEarningAction extends StatelessWidget {
  final PointEarningRuleUiModel model;
  final Function(PointEarningRuleUiModel model)? onTap;
  final bool isBackgroundDark;

  const ItemPointEarningAction({
    required this.model,
    this.onTap,
    this.isBackgroundDark = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  Ripple(
        //   onTap: () => onTap?.call(model),
        Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      model.iconPath,
                      width: 14.w,
                      height: 20.h,
                      color: _getColor(),
                    ).marginOnly(right: 20.w),
                    _getTitleSubtitleWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      // ),
    );
  }

  Widget _getTitleSubtitleWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.title,
            style: smallBold16Primary(color: _getColor()),
          ),
          Text(
            model.subtitle,
            style: smallRegular16Primary(color: _getColor()),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    return isBackgroundDark ? GlorifiColors.white : GlorifiColors.midnightBlue;
  }
}
