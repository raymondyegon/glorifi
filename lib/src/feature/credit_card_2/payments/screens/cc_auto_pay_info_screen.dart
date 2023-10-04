import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_auto_pay_amount_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class CCAutoPayInfoScreen extends StatelessWidget {
  const CCAutoPayInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: 'Let’s get your auto pay set up. ',
      children: _children(),
      ctaTitle: "Set up Auto Pay",
      onContinue: () => Get.to(() => CCAutoPayAmountScreen()),
    );
  }

  List<Widget> _children() {
    return [
      Text(
        TextConstants.autoPayInfo,
        style: TextStyle(
            color: GlorifiColors.midnightBlue,
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.w400),
      ),
      SizedBox(
        height: 30,
      )
    ];
  }
}
