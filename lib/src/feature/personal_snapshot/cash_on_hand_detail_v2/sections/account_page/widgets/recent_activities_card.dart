import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/account_details_page_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/widgets/transaction_card.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AccountDetailsPageController>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Univers',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // List of transactions card
          Card(
            color: Colors.white,
            child: Column(
              children: [
                // Transactions
                Column(
                  children: controller.activities.length == 0
                      ? [
                          Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(
                              'No activities',
                            ),
                          )
                        ]
                      : [
                          ...controller.activities.map(
                            (transaction) {
                              return TransactionCard(transaction);
                            },
                          ).toList(),
                        ],
                ),

                controller.activities.length != 0
                    ? Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFF0F0F0),
                        ),
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Load More',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
