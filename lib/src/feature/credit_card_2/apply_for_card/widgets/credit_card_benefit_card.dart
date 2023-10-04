import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/entrypoint/models/credit_card_benefits_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class CreditCardBenefitCard extends StatelessWidget {
  final VoidCallback onTap;
  final String assetPath;
  final CreditCardBenefitsModel cardBenefitsModel;

  const CreditCardBenefitCard(
      {Key? key,
      required this.assetPath,
      required this.cardBenefitsModel,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,13),
              blurRadius: 55,
              spreadRadius: -7,
              color: GlorifiColors.black.withOpacity(.25)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    assetPath,
                    width: 96.w,
                    height: 60.h,
                  ),
                ).paddingOnly(right: 19.w),
                Flexible(
                  child: Text(
                    cardBenefitsModel.title!,
                    style: bodyRegular18Secondary(
                      color: GlorifiColors.darkBlue,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              cardBenefitsModel.description!,
              style: captionRegular14Primary(
                color: GlorifiColors.darkBlueTint[800],
              ),
            ).paddingOnly(top: 16.h, bottom: 15.h),
            Text(
              TextConstants.seeBenefits,
              style: captionRegular14Primary(
                color: GlorifiColors.cameraCancelRed,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
