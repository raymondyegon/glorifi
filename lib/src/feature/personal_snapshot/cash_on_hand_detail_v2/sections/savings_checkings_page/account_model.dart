import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_controller.dart';

class Account {
  Account({
    required this.accountId,
    required this.balance,
    required this.institution,
    required this.name,
    required this.mask,
    required this.logo,
    required this.thirtyDayBalance,
  });
  late final String accountId;
  late final double balance;
  late final String institution;
  late final String name;
  late final String mask;
  late final Image logo;
  late final List<ChartData> thirtyDayBalance;
}
