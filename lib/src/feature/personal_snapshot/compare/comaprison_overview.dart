import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/comparison_feature_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../utils/glorifi_colors.dart';
import '../home_value/common_widget.dart';
import 'compare_value.dart';

class ComparisonOverview extends GetView<ComparisonFeatureController> {
  const ComparisonOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => _content(), onError: (_) => _content());
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: GlorifiColors.bgDarkGrey,
        ),
        SizedBox(
          height: 16.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  glorifiText(
                    text: getSubTitle(),
                    textStyle: glorifiTextStyle(
                      fontSize: 16.0.sp,
                      textColor: GlorifiColors.cornflowerBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Obx(
                    () => glorifiText(
                      text: controller.filterData.value.isEmpty ? '' : controller.filterData.value,
                      textStyle: glorifiTextStyle(
                        fontSize: 16.0.sp,
                        textColor: GlorifiColors.ebonyBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            SizedBox(
              width: 10.0.w,
            ),
            GestureDetector(
              onTap: () {
                controller.isEditing.value = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: GlorifiColors.darkBlueTint[500],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: glorifiText(
                  text: 'Edit',
                  textStyle: glorifiTextStyle(
                    fontSize: 12.0.sp,
                    textColor: GlorifiColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.0.h,
        ),
        controller.noDataForMember.isTrue
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 23,
                ),
                decoration: BoxDecoration(
                  color: GlorifiColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: GlorifiColors.black.withOpacity(0.1),
                      blurRadius: 55,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(GlorifiAssets.alertCircle, height: 24, color: GlorifiColors.lightRed,),
                    SizedBox(width: 8),
                    Text(
                      'Sorry, we can’t find any data.\nTry editing your information.',
                      style: xSmallRegular12Primary(color: GlorifiColors.ebonyBlue),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.gloriFiCompareType != GloriFiCompareType.creditScore)
                        Container(
                          child: glorifiText(
                            text: r"$",
                            textStyle: headlineBold48Secondary(color: GlorifiColors.biscayBlue),
                          ),
                        ),
                      glorifiText(
                        text: controller.comparisonAmount.value,
                        textStyle: headlineBold48Secondary(color: GlorifiColors.biscayBlue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  glorifiText(
                    text: getValue() + controller.memberAmount.value,
                    textStyle: glorifiTextStyle(
                      fontSize: 16.0.sp,
                      textColor: GlorifiColors.midnightBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
        SizedBox(
          height: 15.0.h,
        ),
        Divider(
          color: GlorifiColors.bgDarkGrey,
        ),
        SizedBox(
          height: 15.0.h,
        ),
        glorifiText(
          text: getDesc(),
          textStyle: glorifiTextStyle(
              fontSize: 12.0.sp,
              textColor: GlorifiColors.ebonyBlue,
              fontWeight: FontWeight.normal,
              italic: true),
        ),
        SizedBox(
          height: 25.0.h,
        ),
        glorifiText(
          text:
              'We use data that all financial institutions collect and use every day to assess your financial wellness. Never before has this data been available to the public. GloriFi believes in data transparency, we\'re pulling back the curtain so you can take control of your wealth and your future.',
          textStyle: xSmallRegular12Primary(color: GlorifiColors.ebonyBlue),
        ),
      ],
    );
  }

  String getSubTitle() {
    switch (controller.gloriFiCompareType) {
      case GloriFiCompareType.netWorth:
        return 'Average Net Worth';
      case GloriFiCompareType.homeValue:
        return 'Average Home Value';
      case GloriFiCompareType.creditScore:
        return 'Average Credit Score';
      case GloriFiCompareType.retirementSavings:
        return 'Average Retirement Savings';
      case GloriFiCompareType.creditDebt:
        return 'Average Credit Debt';
      case GloriFiCompareType.cashOnHand:
        return 'Average Cash on Hand';
    }
  }

  String getValue() {
    switch (controller.gloriFiCompareType) {
      case GloriFiCompareType.netWorth:
        return 'Your Net Worth: ';
      case GloriFiCompareType.homeValue:
        return 'Your Home Value: ';
      case GloriFiCompareType.creditScore:
        return 'Your Credit Score: ';
      case GloriFiCompareType.retirementSavings:
        return 'Your Retirement Savings: ';
      case GloriFiCompareType.creditDebt:
        return 'Your Credit Debt: ';
      case GloriFiCompareType.cashOnHand:
        return 'Your Cash on Hand: ';
    }
  }

  String getDesc() {
    switch (controller.gloriFiCompareType) {
      case GloriFiCompareType.netWorth:
        return '*These results are based on average net worth of people in your group results can vary.';
      case GloriFiCompareType.homeValue:
        return '*These results are based on average home value of people in your group results can vary.';
      case GloriFiCompareType.creditScore:
        return '*These results are based on average credit scores of people in your group results can vary.';
      case GloriFiCompareType.retirementSavings:
        return '*These results are based on average retirement savings of people in your group results can vary.';
      case GloriFiCompareType.creditDebt:
        return '*These results are based on average credit debt of people in your group results can vary.';
      case GloriFiCompareType.cashOnHand:
        return '*These results are based on average salaries of people in your group results can vary.';
    }
  }
}
