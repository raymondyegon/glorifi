import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/glorifi_logos/glorifi_logos.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key? key,
    required this.name,
    required this.description,
  }) : super(key: key);

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        color: GlorifiColors.primaryButtonProgressColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 55,
            spreadRadius: 0,
            color: GlorifiColors.black.withOpacity(.10),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: bodySemiBold18Primary(
                  color: GlorifiColors.lightWhite,
                ),
              ),
              SizedBox(height: 21.h),
              Text(
                description,
                style: captionRegular14Primary(
                  color: GlorifiColors.lightWhite,
                ),
              ),
            ],
          ).paddingOnly(left: 16.w, top: 22.h, bottom: 27.h),
          GloriFiLogos(
            imageKey: GlorifiLogos.logoBrandMarkDarkBbgSm,
            width: 68.w,
            height: 63.h,
          ).paddingOnly(right: 14.w, top: 10.h),
        ],
      ),
    );
  }
}
