import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/comparison_feature_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/compare/comaprison_overview.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/common_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../widgets/loading/glorifi_spinner.dart';
import 'edit_compare_value.dart';

enum GloriFiCompareType {
  netWorth,
  cashOnHand,
  creditScore,
  retirementSavings,
  creditDebt,
  homeValue,
}

class CompareValueScreen extends StatefulWidget {
  final gloriFiCompareState;
  final String? member;

  CompareValueScreen({
    required this.gloriFiCompareState,
    required this.member,
    Key? key,
  }) : super(key: key);

  @override
  State<CompareValueScreen> createState() => _CompareValueScreenState();
}

class _CompareValueScreenState extends State<CompareValueScreen> {
  ComparisonFeatureController controller = Get.put(
    ComparisonFeatureController(),
    permanent: false,
  );

  final Widget loader = Expanded(
      child: Center(
    child: Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GlorifiSpinner(),
    ),
  ));

  @override
  void initState() {
    controller.gloriFiCompareType = widget.gloriFiCompareState;
    controller.getComparison();
    controller.compareState = widget.gloriFiCompareState;
    controller.member.value = widget.member ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.10))
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: 46.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: GlorifiColors.swipeColor,
              borderRadius: BorderRadius.all(
                Radius.circular(18.r),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 16.w, top: 11.h),
            child: GestureDetector(
              onTap: Get.back,
              child: Text(
                "Close",
                style: captionSemiBold14Primary(
                    color: GlorifiColors.lightRedTint[500]),
              ),
            ),
          ),
          Obx(
            () => controller.loading.isTrue
                ? loader
                : Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 24.w),
                          child: SvgPicture.asset(
                            getAssetIconPath(),
                            height: 35.w,
                            width: 35.w,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                top: 28.0.h, left: 8.0.w, right: 8.0.w),
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  glorifiText(
                                    text: getTitle(),
                                    textStyle: glorifiTextStyle(
                                        fontSize: 26.0.sp,
                                        textColor: GlorifiColors.cornflowerBlue,
                                        fontWeight: FontWeight.w400,
                                        font: "univers"),
                                  ),
                                  SizedBox(
                                    height: 24.0.h,
                                  ),
                                  getCurrentView()
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget getCurrentView() {
    return Obx(() => controller.isEditing.isTrue
        ? EditCompareValue()
        : ComparisonOverview());
  }

  String getAssetIconPath() {
    switch (widget.gloriFiCompareState) {
      case GloriFiCompareType.netWorth:
        return 'assets/icons/ic_dollar.svg';
      case GloriFiCompareType.homeValue:
        return 'assets/icons/ic_home.svg';
      case GloriFiCompareType.creditScore:
        return 'assets/icons/ic_credit_score.svg';
      case GloriFiCompareType.retirementSavings:
        return 'assets/icons/ic_saving.svg';
      case GloriFiCompareType.creditDebt:
        return 'assets/icons/ic_clock.svg';
      case GloriFiCompareType.cashOnHand:
        return 'assets/icons/ic_compare_cash_on_hand.svg';
    }
    return '';
  }

  String getTitle() {
    if (controller.isEditing.isTrue)
      return "Edit";
    else
      switch (widget.gloriFiCompareState) {
        case GloriFiCompareType.netWorth:
          return 'Compare Net Worth';
        case GloriFiCompareType.homeValue:
          return 'Compare Home Value';
        case GloriFiCompareType.creditScore:
          return 'Compare Credit Score';
        case GloriFiCompareType.retirementSavings:
          return 'Compare Retirement Savings';
        case GloriFiCompareType.creditDebt:
          return 'Compare Credit Debt';
        case GloriFiCompareType.cashOnHand:
          return 'Compare Cash on Hand';
      }
    return '';
  }

  String getSubTitle() {
    switch (widget.gloriFiCompareState) {
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
    return '';
  }

  String getValue() {
    switch (widget.gloriFiCompareState) {
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
    return '';
  }

  String getDesc() {
    switch (widget.gloriFiCompareState) {
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
    return '';
  }
}
