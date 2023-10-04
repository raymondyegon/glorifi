import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/models/cc_funding_accounts_model.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_auto_pay_date_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_date_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCPaymentAccountScreen extends GetView<CCPaymentsController> {
  const CCPaymentAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "How would you like to pay?",
      children: _children(),
    );
  }

  Widget _account(CCFundingAccountModel model) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.bankName,
                style: TextStyle(
                    color: GlorifiColors.darkBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${model.accountType} • ${model.lastFourDigits}",
                style: TextStyle(color: GlorifiColors.grey9E),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r"$" + model.balance.toStringAsFixed(2),
                style: TextStyle(
                    color: GlorifiColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "available",
                style: TextStyle(color: GlorifiColors.grey9E),
              )
            ],
          )
        ],
      ).paddingAll(10),
      onTap: () async {
        await Future.delayed(Duration(milliseconds: 300));
        controller.selectedFundingAccount = model;
        if (controller.isAutoPay) {
          Get.to(() => CCAutoPayDateScreen());
        } else {
          Get.to(() => CCPaymentDateScreen());
        }
      },
    );
  }

  List<Widget> _children() {
    PlaidController plaidController = Get.put(PlaidController());

    return [
      ...List.generate(controller.fundingAccounts.length,
          (index) => _account(controller.fundingAccounts[index])),
      SizedBox(
        height: 20,
      ),
      PrimaryButton(
        avoidShadow: true,
        textColor: GlorifiColors.darkBlueColor,
        height: 64.h,
        title: 'Link new account',
        isLoading: plaidController.isLoading.value,
        onTap: () async {
          await plaidController.openPlaid(flowType: PlaidFlowType.creditCard);
        },
      ),
    ];
  }
}
