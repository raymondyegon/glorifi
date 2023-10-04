import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class AccountDetails extends StatelessWidget {
  static const routeName = '/accountDetails';
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Done Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: Get.back,
                    child: Text("Done",
                        style: TextStyle(
                          color: GlorifiColors.bloodOrange,
                        )))
              ],
            ),

            /// Account Balance Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Checking",
                    style: TextStyle(
                      color: GlorifiColors.textColorBlack,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        // ignore: use_raw_strings
                        "\$8,580.00",
                        style: TextStyle(
                          color: GlorifiColors.cornflowerBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Available Balance",
                        style: TextStyle(
                          color: GlorifiColors.textColorGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  /// Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            /// Transaction List
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: Colors.grey[200],
                margin: EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),

                      /// Processing
                      Text(
                        "Processing",
                        style: TextStyle(color: GlorifiColors.bloodOrange),
                      ),
                      SizedBox(height: 30),
                      TransactionCard(),
                      Divider(),
                      SizedBox(height: 30),

                      /// List of Transaction Date Wise
                      Text("December 28, 2021"),
                      SizedBox(height: 30),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                TransactionCard(),
                                Divider(),
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction Name"),
            Text("Location"),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "+22.00",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              // ignore: use_raw_strings
              "\$320000.00",
              style: TextStyle(color: GlorifiColors.textColorGrey),
            ),
          ],
        )
      ],
    );
  }
}
