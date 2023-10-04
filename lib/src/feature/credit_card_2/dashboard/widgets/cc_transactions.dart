import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_transaction_model.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/model/cc_transaction_details_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCDashboardTransactions extends GetView<CCDashboardController> {
  const CCDashboardTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      width: 1.sw,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Transactions",
          style: TextStyle(
              fontSize: 32,
              fontFamily: 'UniversWide',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.transactions.keys.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _dateSection(
                        controller.transactions.keys.elementAt(index)));
              },
            )),
        SizedBox(height: 20),
        PrimaryButton(
          title: "Load More",
          primaryColor: GlorifiColors.bgColor,
          textColor: GlorifiColors.darkBlueColor,
          fontSize: 14,
          avoidShadow: true,
          onTap: () async {
            await controller.fetchMoreTransactions();
          },
        ),
        SizedBox(height: 5),
        PrimaryButton(
          title: "View Statement",
          hasRightArrow: true,
          fontSize: 14,
          primaryColor: GlorifiColors.white,
          textColor: GlorifiColors.darkBlueColor,
          avoidShadow: true,
          onTap: () {},
        ),
        SizedBox(height: 50),
      ]),
    );
  }

  Widget _amount(CCTransactionDetailsModel ccTransaction) {
    if (ccTransaction.tip_amount != null || ccTransaction.tip_amount! != 0.0) {
      double returnedAmount = ccTransaction.amount! + ccTransaction.tip_amount!;
      return ccTransaction.amount! < 0
          ? Text("-\$${(ccTransaction.amount! * -1).toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: GlorifiColors.gradientDarkGreen))
          : Text("\$${returnedAmount.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ));
    }
    return ccTransaction.amount! < 0
        ? Text("-\$${(ccTransaction.amount! * -1).toStringAsFixed(2)}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: GlorifiColors.gradientDarkGreen))
        : Text("\$${ccTransaction.amount!.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ));
  }

  Widget _transaction(CCTransactionDetailsModel ccTransaction) {
    Widget _getImage() {
      if (ccTransaction.network_data!.merchant_category_code != null) {
        return SvgPicture.asset(
          ccTransaction.network_data!.merchant_category_code!,
          width: 15,
          color: GlorifiColors.darkBlue,
        );
      }
      return SizedBox.shrink();
    }

    return Column(children: [
      SizedBox(
        height: 5,
      ),
      InkWell(
          onTap: () {
            Get.toNamed(Routes.ccTransactionDetailsScreen,
                arguments: ccTransaction);
          },
          child: Row(
            children: [
              Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: GlorifiColors.silver.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(3)),
                  child: _getImage()),
              SizedBox(
                width: 15,
              ),
              Text(
                ccTransaction.network_data!.merchant_name!,
              ),
              Spacer(),
              ccTransaction.status == "pending"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _amount(ccTransaction),
                        Text(
                          "Pending",
                          style: TextStyle(
                              color: GlorifiColors.silver, fontSize: 12),
                        )
                      ],
                    )
                  : _amount(ccTransaction),
            ],
          )),
      SizedBox(
        height: 5,
      ),
      Divider(),
    ]);
  }

  List<Widget> _dateSection(String date) {
    return [
      SizedBox(height: 30),
      Text(
        date,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 10,
      ),
      Divider(),
      Obx(() => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.transactions[date]!.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return _transaction(controller.transactions[date]![index]);
          }))
    ];
  }
}
