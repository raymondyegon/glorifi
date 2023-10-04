import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AccountTile extends GetWidget {
  AccountTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.amount,
      this.allowPadding = true,
      this.showAmount = true})
      : super(key: key);

  final String title;
  final String desc;
  final double amount;
  final bool allowPadding;
  final bool showAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: allowPadding ? 16.w : 0,
          vertical: allowPadding ? 16.h : 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: captionBold14Primary(),
                  ),
                  if (desc != "")
                    SizedBox(
                      height: 4.h,
                    ),
                  if (desc != "")
                    Text(
                      desc,
                      style: xSmallRegular12Primary(),
                    )
                ]),
          ),
          SizedBox(width: 16.w),
          if (showAmount)
            Container(
              margin: EdgeInsets.only(bottom: 4.h),
              child: Text(amount.formatCurrencyWithZero(),
                  style:
                      headlineBold21Secondary(color: GlorifiColors.biscayBlue),
                  maxLines: 1),
            )
        ],
      ),
    );
  }
}
