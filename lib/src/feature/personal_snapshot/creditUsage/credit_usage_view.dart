// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_usage_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/creditUsage/common_widget.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';


import '../../../widgets/appbars/glorifi_appbar.dart';

class CreditUsageView extends GetView<CreditUsageController> {
  const CreditUsageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: 'Personal Snapshot',
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<CreditUsageController>(
          builder: (controller) => Container(
            margin: EdgeInsets.all(25.0.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Get.toNamed(Routes.creditUsageDetails),
                    },
                    child: _creditUsage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _creditUsage() {
    String des =
        "Credit usage refers to the amount of credit you have used compared with how much credit you have been extended by a lender.";

    return Container(
      width: double.infinity,
      decoration: glorifiBoxDecoration(),
      padding: EdgeInsets.all(25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: glorifiText(
                  text: 'Credit Usage',
                  textStyle: glorifiTextStyle(
                    fontSize: 25.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: GlorifiColors.textColor,
                size: 20.0.w,
              ),
            ],
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Row(
            children: [
              glorifiText(
                text: '${controller.creditUsageData.percentage}%',
                textStyle: glorifiTextStyle(
                  fontSize: 30.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                width: 2.0.w,
                color: GlorifiColors.textColor,
                height: 35.0.h,
              ),
              Visibility(
                visible: controller.isLinkCard,
                child: glorifiText(
                  text: controller.creditUsageData.creditStatus,
                  textStyle: glorifiTextStyle(
                    fontSize: 26.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
              Expanded(
                child: glorifiText(
                  text: controller.isLinkCard
                      ? 'Across All Linked Accounts'
                      : 'No Accounts Linked',
                  textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
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
                decoration:
                    glorifiBoxDecoration(bgColor: Colors.grey, radius: 100.w),
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
          _creditDebit(),
          glorifiText(
            text: des,
            textStyle: glorifiTextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
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
}
