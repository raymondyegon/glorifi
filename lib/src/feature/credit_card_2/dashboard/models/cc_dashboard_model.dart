import 'dart:developer';

enum CCStatus { SUSPENDED, ACTIVE, PENDING, CLOSED }

class CCDashboardModel {
  double remainingStatementBalance;
  double availableCredit;
  double remainingMinimumPaymentDue;
  DateTime dueDate;
  DateTime? autoPay;
  String cardImageUrl;
  int numberActiveDisputes;
  CCStatus status;
  double currentBalance;
  final String accountNumber;
  final String type;

  String get lastFourDigits =>
      accountNumber.substring(accountNumber.length - 4, accountNumber.length);
  String get cardName => !accountNumber.isEmpty ? "Card *$lastFourDigits" : "";

  double get percent => currentBalance / availableCredit;
  String get creditUtilization => "${(percent * 100).toInt()}%";

  CCDashboardModel(
      {required this.availableCredit,
      required this.remainingMinimumPaymentDue,
      required this.dueDate,
      this.autoPay,
      required this.status,
      required this.cardImageUrl,
      required this.currentBalance,
      required this.accountNumber,
      required this.type,
      required this.numberActiveDisputes,
      required this.remainingStatementBalance});

  static CCDashboardModel empty() {
    return CCDashboardModel(
      currentBalance: 0.0,
      accountNumber: '',
      type: '',
      availableCredit: 0,
      remainingStatementBalance: 0.0,
      remainingMinimumPaymentDue: 0,
      dueDate: DateTime.now(),
      cardImageUrl: '',
      status: CCStatus.ACTIVE,
      numberActiveDisputes: 0,
    );
  }

  factory CCDashboardModel.fromJson(Map<String, dynamic> json) {
    String? cardImageUrl(String cardDesignType) {
      if (cardDesignType == "brass") {
        return "https://core-assets.azureedge.net/assets/images/cards/debit/BRASS_DEBIT_01.png";
      } else if (cardDesignType == "thin_blue_line") {
        return "https://core-assets.azureedge.net/assets/images/cards/debit/1776_DEBIT_01.png";
      } else if (cardDesignType == "constitution") {
        return "https://core-assets.azureedge.net/assets/images/cards/debit/BRASS_DEBIT_01.png";
      } else if (cardDesignType == "1776") {
        return "https://core-assets.azureedge.net/assets/images/cards/debit/BRASS_DEBIT_01.png";
      }
    }
    return CCDashboardModel(
      currentBalance: json['current_balance'],
      remainingStatementBalance: json['remaining_statement_balance'],
      accountNumber: json['cp_account_number'],
      type: '{Card Type}', // TODO:
      availableCredit: json['available_credit'],
      remainingMinimumPaymentDue: json["remaining_minimum_payment_due"],
      dueDate: DateTime.parse(json['due_date']),
      autoPay: (json['schedules'] != null &&
              json['schedules'][0] != null &&
              json['schedules'][0]['payment_date'] != null)
          ? DateTime.parse(json['schedules'][0]['payment_date'])
          : null,
      cardImageUrl: cardImageUrl(
          "brass")!, //TODO: cardImageUrl(json['card_design_type'])!,
      numberActiveDisputes: 0, // TODO: ,
      status: CCStatus.values.firstWhere((e) => e.name == json["status"]),
    );
  }
}
