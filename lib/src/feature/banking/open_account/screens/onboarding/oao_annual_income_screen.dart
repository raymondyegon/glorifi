import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_verify_ssn_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class OAOAnnualIncomeScreen extends GetView<OAOController> {
  const OAOAnnualIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
        info: OAOScreensInfo.OAOAnnualIncomeScreen,
        children: _content(context),
        onContinue: () async {
          Get.to(() => OAOVerifySSNScreen());
        });
  }

  List<Widget> _content(BuildContext context) {
    return [
      GlorifiTextField(
        autofocus: true,
        label: "Annual Income",
        keyboardType: TextInputType.number,
        onChanged: (value) {
          controller.application.income = int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
        },
        inputFormatters: [
          CurrencyTextInputFormatter(symbol: r"$", decimalDigits: 0),
        ],
      )
    ];
  }
}
