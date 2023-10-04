
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_transfer_success.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_cd.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_funding_accounts_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class OAODepositScreen extends GetView<OAOController> {
  OAODepositScreen({Key? key}) : super(key: key);

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAODepositScreen,
      children: _content(),
      onContinue: () async {
        bool successful = false;
        try {
          final res =
              await controller.makeDeposit(double.parse(_amountController.text.replaceAll(RegExp("[^0-9 .]"), "")));

          if (res['status'] == 'Success') {
            successful = true;
          }

        } catch (e) {
          OAOController.showGenericErrorSnackBar(context);
        }
        if (successful) {
          switch (controller.application.selectedProduct!.group) {
            case 'DDA':
              //Checking
              await controller.fetchDebitCardOptions();
              return Get.to(() => OAOTransferSuccess());
            case 'SAV':
              return Get.to(() => OAOTransferSuccess());
            case 'CD':
              return Get.to(() => OAOCD());
          }
        } else {
          OAOController.showGenericErrorSnackBar(context);
        }
      },
    );
  }

  List<Widget> _content() {
    return [
      FundingAccountItem(
        balance: controller.selectedFundingAccount.value!.balance,
        institutionName: controller.selectedFundingAccount.value!.institution ?? '',
        mask: controller.selectedFundingAccount.value!.mask ?? '',
        name: controller.selectedFundingAccount.value!.name ?? '',
        status: '1',
          isSelected: true
      ),
      SizedBox(height: 16.h),
      GlorifiTextField(
        textEditingController: _amountController,
        label: 'Transfer Amount',
        keyboardType: TextInputType.number,
        autofocus: true,
        validator: GlorifiTextField.requiredDepositValidation(
          min: controller.applicationInProgress.value.selectedProduct?.group == 'CD' ? minCDDeposit.toDouble() : 0,
          max: controller.selectedFundingAccount.value!.balance,
        ),
        inputFormatters: [
          CurrencyTextInputFormatter(symbol: r"$", decimalDigits: 2),
        ],
      ),
    ];
  }
}
