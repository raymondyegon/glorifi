import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_auto_pay_confirmation.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_confirmation_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:intl/intl.dart';

class CCPaymentConfirmScreen extends GetView<CCPaymentsController> {
  const CCPaymentConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "Confirm payment for Brass •••• " +
          controller.accountModel.lastFourDigits,
      children: _children(),
      ctaTitle: controller.isAutoPay ? "Set" : "Confirm Payment",
      onContinue: () async {
        bool success = await controller.ccSchedulePayment();
        if (!success) {
          showSnackBar(
            'Error Sending Payment',
          );
          return;
        }
        if (controller.isAutoPay) {
          Get.to(() => CCAutoPayConfirmation());
        } else {
          Get.to(() => CCPaymentConfirmationScreen());
        }
      },
      showArrowOnCta: false,
    );
  }

  Widget _row(String label, String value, {String? secondValue: null}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: GlorifiColors.darkBlueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              if (secondValue != null)
                Text(
                  secondValue,
                  style: TextStyle(color: GlorifiColors.grey9E, height: 1.8),
                )
            ],
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  List<Widget> _children() {
    return [
      _row(
          "Amount",
          controller.amount != null
              ? "\$" + controller.amount!.toStringAsFixed(2)
              : ccPaymentTypeString(controller.paymentType.value)!),
      _row(
        "From",
        controller.selectedFundingAccount!.bankName,
        secondValue:
            "${controller.selectedFundingAccount!.accountType} • ${controller.selectedFundingAccount!.lastFourDigits}",
      ),
      _row(
          "When",
          controller.isAutoPay
              ? "Custom Date: ${controller.autoPayDate}"
              : DateFormat.yMMMd().format(controller.paymentDate.value)),
      SizedBox(
        height: 20,
      ),
      Text(
        "By “submitting,” I have read and agree to the ACH Agreement.",
        style: TextStyle(fontSize: 16, height: 24 / 16),
      ),
      SizedBox(
        height: 60,
      ),
    ];
  }
}
