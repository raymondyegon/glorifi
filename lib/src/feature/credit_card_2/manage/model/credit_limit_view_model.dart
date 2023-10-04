import 'package:intl/intl.dart';

class CreditLimitModel {
  final double availableCredit;
  final double creditLimit;
  final double apr;

  final usCurrency = NumberFormat("\$#,##0.00", "en_US");

  CreditLimitModel({required this.availableCredit, required this.creditLimit, required this.apr});

  String get availableCreditString => usCurrency.format(availableCredit);
  String get creditLimitString => usCurrency.format(creditLimit);
  String get aprString => usCurrency.format(apr);
}
