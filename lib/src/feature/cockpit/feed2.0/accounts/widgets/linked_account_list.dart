import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/feature/banking/account_transaction_detail.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/text_constants.dart';

import 'account_item.dart';

class LinkedAccountList extends StatelessWidget {
  LinkedAccountList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GloriFiAccountData> dataList = Get.find<AccountsController>()
        .myBankController
        .connectedGloriFiAccountData;
    return Column(
      children: [
        ...List.generate(dataList.length, (index) {
          var data = dataList[index];
          var accountId = data.bankAccountId;
          return AccountItem(
            onTap: () {
              Get.toNamed(Routes.ebsAccountDetails, arguments: {
                "accountId": accountId,
              });
            },
            data: data,
          );
        })
      ],
    );
  }
}
