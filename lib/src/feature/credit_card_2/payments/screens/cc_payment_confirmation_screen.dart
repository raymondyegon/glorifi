import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_auto_pay_info_screen.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:intl/intl.dart';

class CCPaymentConfirmationScreen extends GetView<CCPaymentsController> {
  const CCPaymentConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlorifiColors.darkBlueColor,
        body: Container(
          padding: EdgeInsets.all(20),
          width: 1.sw,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  !DateTime.now()
                          .difference(controller.accountModel.dueDate)
                          .isNegative
                      ? "Thanks for Your payment!"
                      : "Your Payment is Scheduled.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ).paddingSymmetric(horizontal: 20).paddingOnly(bottom: 40),
                Text(
                  DateFormat.yMMMd().format(controller.paymentDate.value),
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: GlorifiColors.white,
                ),
                Text(
                  "\$${controller.amount!.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'univers',
                      fontSize: 63,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: GlorifiColors.white,
                ).paddingOnly(bottom: 30),
                Text(
                  "We will make this payment on ${DateFormat.yMMMd().format(controller.paymentDate.value)}.",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 60,
                ),
                GlorifiOutlinedButton(
                    borderColor: GlorifiColors.darkOrange,
                    primaryColor: Colors.transparent,
                    textColor: GlorifiColors.white,
                    title: "Set Up Auto Pay",
                    onTap: () {
                      controller.isAutoPay = true;
                      Get.to(() => CCAutoPayInfoScreen());
                    }),
                SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                    title: "Done",
                    onTap: () => Get.until(
                        (route) => Get.currentRoute == Routes.ccDashboard))
              ]),
        ));
  }
}
