import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import 'controller/expense_controller.dart';

class ACCHousingCostScreen extends GetView<ExpenseController> {
  const ACCHousingCostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      children: _content(),
      info: ACCScreensInfo.ACCHousingCostScreen,
      onContinue: () async {
        await controller.validateExpenseInformation();
        if (controller.pageState == PageState.SUCCESS)
          Get.toNamed(Routes.accReviewApplicationScreen);
      },
    );
  }

  List<Widget> _content() {
    String hint = TextConstants.monthlyHousingCost;

    return [
      GlorifiTextField(
        textEditingController: controller.expensesController,
        label: hint,
        keyboardType: TextInputType.number,
        validator: GlorifiTextField.requiredFieldValidator(hint.toLowerCase()),
        inputFormatters: [
          CurrencyTextInputFormatter(symbol: r'$', decimalDigits: 0)
        ],
      ),
    ];
  }
}
