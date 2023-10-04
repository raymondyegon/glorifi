import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_account_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/widgets/clickable_tile.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import 'cc_link_account_screen.dart';

class CCPaymentAmountScreen extends StatefulWidget {
  CCPaymentAmountScreen({Key? key}) : super(key: key) {
    if (Get.arguments != null) {
      Get.put(
          CCPaymentsController(accountModel: Get.arguments['accountModel']));
    }
  }

  @override
  State<CCPaymentAmountScreen> createState() => _CCPaymentAmountScreenState();
}

class _CCPaymentAmountScreenState extends State<CCPaymentAmountScreen> {
  CCPaymentsController controller = Get.find();
  TextEditingController _customAmountController = TextEditingController();
  bool showButton = false;


  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "How much would you like to pay?",
      ctaTitle: showButton ? 'Continue' : null,
      children: _children(),
      onContinue: showButton
          ? () async {
              if (controller.amount == null || controller.amount == 0) {
                return;
              }
              await controller.fetchFundingAccounts();
              if (controller.fundingAccounts.length > 0) {
                Get.to(CCPaymentAccountScreen());
              } else {
                Get.to(CCLinkAccountScreen());
              }
            }
          : null,
    );
  }

  Widget _tile(String title, double amount, int index) {
    return ClickableTile(
        title: title,
        amount: amount,
        onTap: () async {
          setState(() {
            showButton = false;
          });
          _customAmountController.text = "";
          controller.amount = amount;
          await controller.fetchFundingAccounts();
          if (controller.fundingAccounts.length > 0) {
            Get.to(CCPaymentAccountScreen());
          } else {
            Get.to(CCLinkAccountScreen());
          }
        });
  }

  List<Widget> _children() {
    return [
      _tile(
        "Pay Off Account",
        controller.accountModel.currentBalance,
        0,
      ),
      _tile("Last Statement", controller.accountModel.remainingStatementBalance,
          1),
      _tile(
          "Minimum Due", controller.accountModel.remainingMinimumPaymentDue, 2),
      GlorifiTextField(
        textEditingController: _customAmountController,
        onTap: () {
          setState(() {
            showButton = true;
          });
        },
        onChanged: (String value) {
          controller.amount =
              double.parse(value.replaceAll(RegExp('[^0-9.]'), ''));
          if (!showButton) {
            setState(() {
              showButton = true;
            });
          }
        },
        validator: GlorifiTextField.optionalValidator,
        label: "Enter Custom Amount",
        keyboardType: TextInputType.number,
        inputFormatters: [
          CurrencyTextInputFormatter(symbol: r"$", decimalDigits: 2),
        ],
      )
    ];
  }
}
