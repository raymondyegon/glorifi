import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_confirm_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:intl/intl.dart';

class CCPaymentCustomDateScreen extends StatefulWidget {
  const CCPaymentCustomDateScreen({Key? key}) : super(key: key);

  @override
  State<CCPaymentCustomDateScreen> createState() =>
      _CCPaymentCustomDateScreenState();
}

class _CCPaymentCustomDateScreenState extends State<CCPaymentCustomDateScreen> {
  CCPaymentsController controller = Get.find();

  String error = "";

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "Chose your payment date.",
      children: _children(),
      ctaTitle: "Continue",
      onContinue: () async {
        setState(() {
          error = "";
        });
        await Future.delayed(Duration(milliseconds: 300));
        Get.to(CCPaymentConfirmScreen());
      },
    );
  }

  List<Widget> _children() {
    return [
      Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(
            () => CalendarCarousel(
              minSelectedDate: DateUtils.dateOnly(DateTime.now()),
              onDayPressed: (DateTime date, List events) {
                controller.paymentDate.value = date;
                if (!controller.paymentDate.value
                    .difference(controller.accountModel.dueDate)
                    .isNegative) {
                  setState(() {
                    error = "The selected date is after the due date";
                  });
                } else {
                   setState(() {
                    error = "";
                  });
                }
              },
              weekdayTextStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              todayButtonColor: GlorifiColors.transparent,
              todayBorderColor: GlorifiColors.transparent,
              todayTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              iconColor: GlorifiColors.lightRed,
              weekendTextStyle: TextStyle(
                color: Colors.black,
              ),
              customDayBuilder: (
                bool isSelectable,
                int index,
                bool isSelectedDay,
                bool isToday,
                bool isPrevMonthDay,
                TextStyle textStyle,
                bool isNextMonthDay,
                bool isThisMonthDay,
                DateTime day,
              ) {
                if (day ==
                    DateUtils.dateOnly(controller.accountModel.dueDate)) {
                  return Center(
                      child: Text(
                    day.day.toString(),
                    style: TextStyle(color: GlorifiColors.red),
                  ));
                } else {
                  return null;
                }
              },
              selectedDayTextStyle: TextStyle(color: Colors.white),
              selectedDayButtonColor: GlorifiColors.lightBlue,
              selectedDayBorderColor: GlorifiColors.transparent,
              headerTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              customGridViewPhysics: NeverScrollableScrollPhysics(),
              weekFormat: false,
              height: 400.0,
              selectedDateTime: controller.paymentDate.value,
              daysHaveCircularBorder: true,
            ),
          )),
      Text(
        "Due Date is: ${DateFormat.yMMMd().format(controller.accountModel.dueDate)}",
        style: TextStyle(fontSize: 16),
      ).paddingOnly(left: 10),
      error != ""
          ? Text(
              error,
              style:
                  TextStyle(color: GlorifiColors.cameraCancelRed, fontSize: 16),
            ).paddingOnly(left: 10, top: 10)
          : SizedBox.shrink()
    ];
  }
}
