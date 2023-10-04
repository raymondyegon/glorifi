import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_confirm_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_custom_date_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:intl/intl.dart';

class CCPaymentDateScreen extends GetView<CCPaymentsController> {
  const CCPaymentDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "When do you want to make this payment?",
      children: _children(context),
    );
  }

  Widget _row(String title, DateTime date) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: GlorifiColors.darkBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat("MMM, d").format(date),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )
            ],
          )),
      onTap: () async {
        controller.paymentDate.value = date;
        await Future.delayed(Duration(milliseconds: 300));
        Get.to(CCPaymentConfirmScreen());
      },
    );
  }

  List<Widget> _children(context) {
    return [
      _row("Pay now", DateTime.now()),
      SizedBox(
        height: 20,
      ),
      _row("Pay on the due date", controller.accountModel.dueDate),
      SizedBox(
        height: 20,
      ),
      InkWell(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose another date",
                    style: TextStyle(
                        color: GlorifiColors.darkBlueColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.calendar_month_rounded),
                ])),
        onTap: () async {
          await Future.delayed(Duration(milliseconds: 300));
          Get.to(CCPaymentCustomDateScreen());
        },
      )
    ];
  }
}
