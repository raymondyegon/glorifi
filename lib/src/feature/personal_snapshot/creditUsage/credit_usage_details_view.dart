// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_usage_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/creditUsage/common_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';


import '../../../widgets/appbars/glorifi_appbar.dart';

class CreditUsageDetailsView extends GetView<CreditUsageController> {
  const CreditUsageDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String des =
        "Credit usage refers to the amount of credit you have used compared with how much credit you have been extended by a lender.";

    return Scaffold(
      appBar: GlorifiAppBar(
        title: 'Credit Usage',
      ),
      backgroundColor: GlorifiColors.bgBoxColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25.0.h),
          child: GetBuilder<CreditUsageController>(
            builder: (controller) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      glorifiText(
                        text: '${controller.creditUsageData.percentage}%',
                        textStyle: glorifiTextStyle(
                          fontSize: 40.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: controller.isLinkCard,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                          width: 2.0.w,
                          color: GlorifiColors.textColor,
                          height: 35.0.h,
                        ),
                      ),
                      Visibility(
                        visible: controller.isLinkCard,
                        child: glorifiText(
                          text: controller.creditUsageData.creditStatus,
                          textStyle: glorifiTextStyle(
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Row(
                    children: [
                      glorifiText(
                        text: 'As of 10 Mar',
                        textStyle: glorifiTextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                        decoration: glorifiBoxDecoration(
                            bgColor: Colors.grey, radius: 100.w),
                        width: 8.0.w,
                        height: 8.0.w,
                      ),
                      glorifiText(
                        text: 'Dallas, TX, USA',
                        textStyle: glorifiTextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0.h,
                  ),
                  _creditDebit(),
                  glorifiText(
                    text: des,
                    textStyle: glorifiTextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30.0.h,
                  ),
                  _linkAccount(),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  _totalAccountDetails(title: 'Total Credit', totalAccounts: 1),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  _totalAccountDetails(
                      title: 'Credit Card Debt', totalAccounts: 1),
                  Visibility(
                    visible: controller.isLinkCard,
                    child: Container(
                      decoration: glorifiBoxDecoration(
                          bgColor: GlorifiColors.denimBlue),
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.0.w, vertical: 40.0.w),
                      margin: EdgeInsets.only(top: 30.h),
                      alignment: Alignment.center,
                      child: glorifiTextCenter(
                        text: 'Get GloriFI Credit Card Banner Add',
                        textStyle: glorifiTextStyle(
                          fontSize: 25.0.sp,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _creditDebit() {
    var totalCredit = controller.creditUsageData.totalCredit;
    var debitCredit = controller.creditUsageData.usedCredit;
    var totalCreditWidth = controller.getTotalCreditWidth(totalCredit);
    var totalDebitCreditWidth = controller.getTotalDebitCreditWidth(
        totalCredit, debitCredit, totalCreditWidth);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          glorifiText(
            text: 'Total Credit',
            textStyle: glorifiTextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0.h),
          Row(
            children: [
              Container(
                color: GlorifiColors.rangeColor,
                height: 30.0.w,
                width: totalCreditWidth,
              ),
              SizedBox(width: 10.0.w),
              Expanded(
                child: glorifiText(
                  text: '\$$totalCredit',
                  textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          glorifiText(
            text: 'Credit Card Debt',
            textStyle: glorifiTextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0.h),
          Row(
            children: [
              Container(
                color: Colors.black54,
                height: 30.0.w,
                width: totalDebitCreditWidth,
              ),
              SizedBox(width: 10.0.w),
              Expanded(
                child: glorifiText(
                  text: '\$$debitCredit',
                  textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _linkAccount() {
    return Visibility(
      visible: !controller.isLinkCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          glorifiText(
            text: 'Total Credit and Credit Card Debt',
            textStyle: glorifiTextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0.h,
          ),
          glorifiButton(
              text: 'Link Credit Cards To See Data',
              onTap: () => {
                    controller.linkCreditCard(),
                  }),
        ],
      ),
    );
  }

  Widget _totalAccountDetails(
      {required String title, required int totalAccounts}) {
    return Visibility(
      visible: controller.isLinkCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          glorifiText(
            text: title,
            textStyle: glorifiTextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Container(
            decoration: glorifiBoxDecoration(bgColor: Colors.white),
            padding: EdgeInsets.all(25.0.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      glorifiText(
                        text: '\$${controller.creditUsageData.totalCredit}',
                        textStyle: glorifiTextStyle(
                          fontSize: 25.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      glorifiText(
                        text: '$totalAccounts Account',
                        textStyle: glorifiTextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: GlorifiColors.textColor,
                  size: 35.0.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
