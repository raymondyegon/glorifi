import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/model/cc_transaction_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/widgets/cc_dispute_transaction_card.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/widgets/cc_merchant_icon.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/widgets/cc_merchant_name.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/widgets/cc_time_and_amount.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/widgets/cc_transaction_detail_list_view.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/controller/cc_transaction_detail_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:intl/intl.dart';
import '../widgets/cc_map_view.dart';
import '../widgets/cc_dispute_transaction_card.dart';

class CCTransactionDetailScreen extends GetView<CCTransactionDetailController> {
  final CCTransactionDetailsModel transaction =
      Get.arguments as CCTransactionDetailsModel;

  CCTransactionDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(CCTransactionDetailController());
    //Convert DateTime To Formatted String
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String dateFormatted = formatter.format(transaction.transacted_at!);
    final String timeFormatted =
        DateFormat.jm().format(transaction.transacted_at!);
    final double totalAmount = transaction.tip_amount! + transaction.amount!;

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          elevation: 0,
          title: "Transaction",
          textStyle: leadSemiBold18Primary(color: GlorifiColors.midnightBlue),
          toolbarHeight: 300,
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    GlorifiColors.bgColor.withOpacity(0.2),
                    GlorifiColors.bgColor.withOpacity(0.2),
                    // GlorifiColors.bgColor
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CCMerchantIcon(
                    icon: transaction.network_data!.merchant_category_code,
                  ), // TODO: Pass value from controller
                  SizedBox(
                    height: 22.0,
                  ),
                  CCMerchantName(
                    name: transaction.network_data!.merchant_name!,
                  ), // TODO: Pass value from controller
                  SizedBox(
                    height: 72.0,
                  ),
                  Text(
                    "${transaction.pos_type!} Transaction",
                    style: leadRegular24Primary(color: GlorifiColors.darkBlue),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  CCTimeAndAmount(
                    date: dateFormatted,
                    time: timeFormatted,
                    status: transaction.status!,
                    amount: totalAmount,
                  ), // TODO: Pass value from controller
                  SizedBox(
                    height: 96.0,
                  ),
                  CCDisputeTransactionCard(
                    icon: controller.disputeTransactionIcon,
                    title: controller.disputeTransactionTitle,
                    balance: controller.disputeTransactionBalance,
                  ), // TODO: Pass actual value from controller
                  SizedBox(
                    height: 98.0,
                  ),
                  Text(
                    "Merchant's Info",
                    style: leadRegular24Primary(color: GlorifiColors.darkBlue),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CCMapView(), // TODO: Complete design and pass value from Controller
                  SizedBox(
                    height: 65.0,
                  ),
                  Text(
                    "${controller.year} Transaction History",
                    style: leadRegular24Primary(color: GlorifiColors.darkBlue),
                  ), // TODO: Provide actual value from controller
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "\$${controller.totalBalance} in spending",
                    style:
                        captionRegular14Primary(color: GlorifiColors.darkBlue),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  CCTransactionDetailListView(
                    icon: controller.transactionListIcon,
                    title: controller.transactionListTitle,
                    balance: controller.transactionListBalance,
                    date: controller.transactionListDate,
                    status: controller.transactionListStatus,
                    itemCount: controller.transactionListCount.value,
                  ) // TODO: Pass actual value from controller
                ],
              )),
        ),
      );
    });
  }
}
