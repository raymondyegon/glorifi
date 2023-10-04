import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/account_details_page.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:intl/intl.dart';

class AccountBalanceCard extends StatelessWidget {
  final String institution;
  final double balance;
  final String mask;
  final bool selected;
  final Image Logo;
  final String accountId;

  var arrowPadding = 0.0.obs;

  AccountBalanceCard({
    required this.institution,
    required this.balance,
    required this.mask,
    required this.selected,
    required this.Logo,
    required this.accountId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: selected ? Color(0xFFBEDCFF) : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: Color(0xFFB7C9EC),
          width: 0.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                Logo,
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        institution + "*" + mask,
                        style: xSmallBold12Primary(color: Color(0xFF444E60)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        formatBalance(balance),
                        style: TextStyle(
                          color: Color(0xFF171A20),
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          InkWell(
            child: AnimatedOpacity(
              opacity: selected ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: AnimatedPadding(
                padding: EdgeInsets.only(right: selected ? 10 : 0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: Container(
                  width: 30,
                  height: 50,
                  child: Icon(
                    Icons.chevron_right,
                    size: 27,
                    color: GlorifiColors.midnightBlue,
                  ),
                ),
              ),
            ),
            onTap: () {
              Get.to(
                AccountDetailsPage(
                  institution: institution,
                  mask: mask,
                  accountId: accountId,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String formatBalance(double balance) {
  double d = balance;
  var format =
      NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: "\$");
  String parsedCurrentBalance = format.format(d);
  return parsedCurrentBalance;
}
