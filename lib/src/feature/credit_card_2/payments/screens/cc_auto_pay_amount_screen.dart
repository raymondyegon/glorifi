
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_account_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/widgets/clickable_tile.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import 'cc_link_account_screen.dart';

class CCAutoPayAmountScreen extends StatefulWidget {
  CCAutoPayAmountScreen({Key? key}) : super(key: key);

  @override
  State<CCAutoPayAmountScreen> createState() => _CCAutoPayAmountScreenState();
}

class _CCAutoPayAmountScreenState extends State<CCAutoPayAmountScreen> {
  CCPaymentsController controller = Get.find();
  bool showButton = false;
  TextEditingController _customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "Select recurring payment option?",
      ctaTitle: showButton ? 'Continue' : null,
      children: _children(),
      onContinue: showButton
          ? () async {
              if (controller.paymentType.value == CCPaymentType.FixedAmount &&
                      controller.amount == null ||
                  controller.amount == 0) {
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

  Widget _tile(String title, CCPaymentType amountType) {
    return ClickableTile(
        title: title,
        onTap: () {
          _customAmountController.text = "";
          controller.amount = null;
          controller.paymentType.value = amountType;
          setState(() {
            showButton = false;
          });
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
        CCPaymentType.CurrentBalance,
      ),
      _tile("Last Statement", CCPaymentType.StatementBalance),
      _tile("Minimum Due", CCPaymentType.MinimumPayment),
      GlorifiTextField(
        textEditingController: _customAmountController,
        onTap: () {
          setState(() {
            showButton = true;
          });
          controller.paymentType(CCPaymentType.FixedAmount);
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
