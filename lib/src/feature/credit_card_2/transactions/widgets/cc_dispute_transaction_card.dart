import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CCDisputeTransactionCard extends StatelessWidget {
  const CCDisputeTransactionCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.balance})
      : super(key: key);

  final List<IconData> icon;
  final List<String> title;
  final List<String?> balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: ListView(
        physics:
            const NeverScrollableScrollPhysics(), // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Charge",
                  style: captionRegular14Primary(color: GlorifiColors.darkBlue),
                ),
                Spacer(),
                Text(
                  "\$${balance[0]}",
                  style: bodyBold18Primary(color: GlorifiColors.darkBlue),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Row(
              children: [
                Icon(Icons.favorite_outline_sharp),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  "Tip Added",
                  style: captionRegular14Primary(color: GlorifiColors.darkBlue),
                ),
                Spacer(),
                Text(
                  "\$${balance[1]}",
                  style: bodyBold18Primary(color: GlorifiColors.darkBlue),
                )
              ],
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Center(
            child: Text(
              "Dispute Transaction",
              style: captionBold14Primary(color: GlorifiColors.darkBlue),
            ),
          ),
          SizedBox(
            height: 28,
          ),
        ],
      ),
    );
  }
}
