import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_fund_your_account_plaid_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/core/logger.dart';

// Step 6 of 6
// https://app.asana.com/0/1202239119682092/1202240186732683/f
class OAOCompleteAccountScreen extends GetView<OAOController> {
  const OAOCompleteAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOCompleteAccountScreen,
      children: _content(),
      onContinue: () async {
        Log.info(
            "Final OAO Form Data: ${controller.applicationInProgress.value}");

        await Get.to(() => OAOFundYourAccountPlaidScreen());
      },
    );
  }

  List<Widget> _content() {
    return [
      Text(
          'Your account number is ${controller.applicationInProgress.value.accountNumber}'),
      Text(
          'And your routing number is ${controller.applicationInProgress.value.routingNumber}')
    ];
  }
}
