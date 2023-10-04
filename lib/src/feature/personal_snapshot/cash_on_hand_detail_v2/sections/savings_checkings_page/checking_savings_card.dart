// ignore_for_file: use_raw_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/checkings_savings_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class CheckingSavingsCard extends StatelessWidget {
  final bool isLoading;
  const CheckingSavingsCard({
    Key? key,
    required this.type,
    required this.isLoading,
  }) : super(key: key);

  final String? type;

  @override
  Widget build(BuildContext context) {
    final cashOnHandController = Get.find<CashOnHandController>();
    return InkWell(
      onTap: () {
        Get.to(CheckingsSavingsScreen(type: type));
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 6,
          left: 20,
          right: 20,
        ),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFD4DEF4), width: 1.16),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Display either Savings, Checking, or Other depending on type
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == "checking") ...[
                    Text(
                      "Total Checking Balance (${cashOnHandController.checkingAccounts.length} ${cashOnHandController.checkingAccounts.length > 1 ? 'Accounts' : 'Account'})",
                      style: xSmallBold12Primary(
                        color: Color(0xFF444E60),
                      ),
                    ),
                    Text(
                      cashOnHandController.totalCheckingAmount.value
                          .formatCurrencyWithZero(),
                      style: TextStyle(
                        fontFamily: "Univers",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF171A20),
                      ),
                    )
                  ] else if (type == "savings") ...[
                    Text(
                      "Total Savings Balance (${cashOnHandController.savingsAccounts.length} Accounts)",
                      style: xSmallBold12Primary(
                        color: Color(0xFF444E60),
                      ),
                    ),
                    Text(
                      cashOnHandController.totalSavingsAmount.value
                          .formatCurrencyWithZero(),
                      style: TextStyle(
                        fontFamily: "Univers",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF171A20),
                      ),
                    )
                  ]
                ],
              ),
            ),

            isLoading ?
            Container(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ) :
            Icon(
              Icons.chevron_right,
              size: 27,
              color: Color(0xFF152951),
            ),
          ],
        ),
      ),
    );
  }
}
