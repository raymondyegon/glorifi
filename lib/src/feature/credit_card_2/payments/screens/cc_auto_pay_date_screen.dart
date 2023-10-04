import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_confirm_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CCAutoPayDateScreen extends GetView<CCPaymentsController> {
  const CCAutoPayDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: 'Select payment date.',
      children: _children(),
    );
  }

  Widget _clickable(Widget child, int day) {
    return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          child:
              Container(padding: EdgeInsets.all(24), width: 1.sw, child: child),
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 300));
            controller.autoPayDate = day;
            Get.to(() => CCPaymentConfirmScreen());
          },
        ));
  }

  Widget _option(int day) {
    return Container(
      child: _clickable(
          Text(
            day.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          day),
      padding: EdgeInsets.only(bottom: 10),
    );
  }

  List<int> _getPrevDays() {
    // max bill day is the 28th.
    // example: bill date is the 2nd this will return [1, 28, 27, 26, 25]

    int _getPositiveDay(int num) {
      return num <= 0 ? 28 + num : num;
    }

    return [1, 2, 3, 4, 5]
        .map((e) => _getPositiveDay(controller.accountModel.dueDate.day - e))
        .toList();
  }

  List<Widget> _children() {
    return [
      _clickable(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "On the due date",
                style: TextStyle(
                    color: GlorifiColors.darkBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                controller.accountModel.dueDate.day.toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ],
          ),
          controller.accountModel.dueDate.day),
      Container(
          padding: EdgeInsets.only(top: 40, bottom: 20, left: 10),
          child: Text(
            "A few days before due date",
            style: TextStyle(
                color: GlorifiColors.darkBlueColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )),
      ..._getPrevDays().map(_option),
    ];
  }
}
