import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';

class AccountModel {
  final String accountName;
  final String accountNumber;
  final double balance;
  final String bankName;
  final AccountType accountType;
  final double? apy;
  final double? interestRate;
  final int? term;

  const AccountModel({
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.balance,
    this.accountType = AccountType.NONE,
    this.apy,
    this.interestRate,
    this.term,
  });
}
