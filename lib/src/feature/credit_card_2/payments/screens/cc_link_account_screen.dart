import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCLinkAccountScreen extends StatelessWidget {
  const CCLinkAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CCPaymentsContainer(
      title: "How would you like to pay?",
      children: _children(),
    );
  }

  List<Widget> _children() {
    PlaidController plaidController = Get.put(PlaidController());

    return [
      Obx(
        () => PrimaryButton(
          avoidShadow: true,
          textColor: GlorifiColors.darkBlueColor,
          height: 64.h,
          title: 'Link Account',
          isLoading: plaidController.isLoading.value,
          onTap: () async {
            await plaidController.openPlaid(flowType: PlaidFlowType.creditCard);
          },
        ),
      ),
    ];
  }
}
