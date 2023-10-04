import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/transactions/ebs_transactions_list.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class EBSAllTransactionsList extends GetView<EBSController> {
  const EBSAllTransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: controller.initAllTransactionsList,
      child: Obx(() {
        return EBSContainer(
          showAppbarShadow: false,
          screenBackground: GlorifiColors.white,
          title: 'Transactions',
          children: _content(),
        );
      }),
    );
  }

  List<Widget> _content() {
    return [
      Expanded(
        child: controller.loadingAllTransactions.value == true
            ? Center(
                child: GlorifiSpinner(),
              )
            : EBSTransactionsList(
                showHeader: false,
                transactions: controller.allTransactions,
                onLoadMore: controller.fetchMoreTransactions,
                loadingMoreTransactions: controller.loadingMoreTransactions.value,
              ),
      )
    ];
  }
}
