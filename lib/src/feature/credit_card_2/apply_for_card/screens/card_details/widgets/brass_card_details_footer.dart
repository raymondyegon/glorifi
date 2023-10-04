import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/brass_card_details_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BrassCardDetailsFooter extends StatelessWidget {
  final BrassCardDetailsFooterModel footer;

  const BrassCardDetailsFooter({required this.footer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            footer.image!,
            width: 152.w,
            height: 95.h,
            fit: BoxFit.fill,
          ),
        ).marginOnly(bottom: 15.h),
        Text(
          footer.title!,
          style: headlineBold26Primary(color: GlorifiColors.white),
        ).marginOnly(bottom: 36.h),
        Text(
          footer.description!,
          style: captionRegular14Primary(color: GlorifiColors.white),
        ).marginOnly(bottom: 50.h),
        Text(
          footer.disclosure!,
          style: captionRegular14Primary(color: GlorifiColors.white),
        ).marginOnly(bottom: 56.h),
      ],
    );
  }
}
