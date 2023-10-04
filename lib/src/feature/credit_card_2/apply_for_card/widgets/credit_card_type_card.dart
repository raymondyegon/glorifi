import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/credit_card_type_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class CreditCardTypeCard extends StatelessWidget {
  const CreditCardTypeCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  final CreditCardTypeModel card;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 55,
            spreadRadius: 0,
            color: GlorifiColors.black.withOpacity(.10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  card.cardAsset!,
                  height: 80.h,
                ),
              ),
              Expanded(
                child: Text(
                  card.annualFee!,
                  textAlign: TextAlign.end,
                  style: smallSemiBold16Primary(
                    color: GlorifiColors.darkGrey,
                  ),
                ).paddingOnly(
                  bottom: 30.h,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 24.w),
          SizedBox(height: 36.h),
          Text(
            card.title!,
            style: bodyRegular18Secondary(
              color: GlorifiColors.darkBlue,
            ),
          ).paddingSymmetric(horizontal: 24.w),
          SizedBox(height: 16.h),
          Text(
            card.description!,
            style: captionRegular14Primary(
              color: GlorifiColors.darkBlue,
            ),
          ).paddingSymmetric(horizontal: 24.w),
          SizedBox(height: 24.h),
          PrimaryDarkButton(
            title: card.buttonText!,
            onTap: () => Get.toNamed(Routes.accChooseCreditCardDesign),
          ).paddingSymmetric(horizontal: 24.w),
          SizedBox(height: 24.h),
          Divider(
            color: GlorifiColors.barrierColor,
            height: 2.h,
          ).paddingOnly(left: 24.w),
          SizedBox(height: 36.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'CARD BENEFITS',
                  style: smallRegular16PrimaryBold(
                    color: GlorifiColors.darkBlue,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 24.sp,
                color: GlorifiColors.textColorGrey,
              ),
            ],
          ).paddingSymmetric(horizontal: 24.w),
        ],
      ),
    );
  }
}
