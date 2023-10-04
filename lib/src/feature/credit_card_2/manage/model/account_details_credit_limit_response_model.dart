import 'package:get/get.dart';

class AccountDetailsCreditLimitResponseModel extends GetxService {
  AccountDetailsCreditLimitResponseModel({
    this.cards,
    this.id,
    this.userId,
    this.accountOpenDate,
    this.dateCreated,
    this.currentBalance,
    this.availableCredit,
    this.highestCreditUtilised,
    this.statementBalance,
    this.creditLimit,
    this.minimumPayment,
    this.dueAmount,
    this.daysPastDueDate,
    this.billingCycleDay,
    this.dueDate,
    this.dueDateUtc,
    this.usage,
    this.status,
    this.reason,
    this.apr,
    this.cashAdvance,
    this.cpAccountNumber,
    this.approvalType,
    this.remainingMinimumPaymentDue,
    this.remainingStatementBalance,
    this.overLimitCredit,
    this.chaUrl,
  });

  List<Card>? cards;
  String? id;
  String? userId;
  DateTime? accountOpenDate;
  DateTime? dateCreated;
  double? currentBalance;
  double? availableCredit;
  double? highestCreditUtilised;
  double? statementBalance;
  int? creditLimit;
  double? minimumPayment;
  int? dueAmount;
  int? daysPastDueDate;
  int? billingCycleDay;
  DateTime? dueDate;
  DateTime? dueDateUtc;
  String? usage;
  String? status;
  String? reason;
  double? apr;
  CashAdvance? cashAdvance;
  String? cpAccountNumber;
  String? approvalType;
  int? remainingMinimumPaymentDue;
  int? remainingStatementBalance;
  int? overLimitCredit;
  String? chaUrl;

  factory AccountDetailsCreditLimitResponseModel.fromJson(
          Map<dynamic, dynamic> json) =>
      AccountDetailsCreditLimitResponseModel(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        id: json["id"],
        userId: json["user_id"],
        accountOpenDate: DateTime.parse(json["account_open_date"]),
        dateCreated: DateTime.parse(json["date_created"]),
        currentBalance: json["current_balance"].toDouble(),
        availableCredit: json["available_credit"].toDouble(),
        highestCreditUtilised: json["highest_credit_utilised"].toDouble(),
        statementBalance: json["statement_balance"].toDouble(),
        creditLimit: json["credit_limit"],
        minimumPayment: json["minimum_payment"].toDouble(),
        dueAmount: json["due_amount"],
        daysPastDueDate: json["days_past_due_date"],
        billingCycleDay: json["billing_cycle_day"],
        dueDate: DateTime.parse(json["due_date"]),
        dueDateUtc: DateTime.parse(json["due_date_utc"]),
        usage: json["usage"],
        status: json["status"],
        reason: json["reason"],
        apr: json["apr"].toDouble(),
        cashAdvance: CashAdvance.fromJson(json["cash_advance"]),
        cpAccountNumber: json["cp_account_number"],
        approvalType: json["approval_type"],
        remainingMinimumPaymentDue: json["remaining_minimum_payment_due"],
        remainingStatementBalance: json["remaining_statement_balance"],
        overLimitCredit: json["over_limit_credit"],
        chaUrl: json["cha_url"],
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards!.map((x) => x.toJson())),
        "id": id,
        "user_id": userId,
        "account_open_date": accountOpenDate!.toIso8601String(),
        "date_created":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
        "current_balance": currentBalance,
        "available_credit": availableCredit,
        "highest_credit_utilised": highestCreditUtilised,
        "statement_balance": statementBalance,
        "credit_limit": creditLimit,
        "minimum_payment": minimumPayment,
        "due_amount": dueAmount,
        "days_past_due_date": daysPastDueDate,
        "billing_cycle_day": billingCycleDay,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "due_date_utc": dueDateUtc!.toIso8601String(),
        "usage": usage,
        "status": status,
        "reason": reason,
        "apr": apr,
        "cash_advance": cashAdvance!.toJson(),
        "cp_account_number": cpAccountNumber,
        "approval_type": approvalType,
        "remaining_minimum_payment_due": remainingMinimumPaymentDue,
        "remaining_statement_balance": remainingStatementBalance,
        "over_limit_credit": overLimitCredit,
        "cha_url": chaUrl,
      };
}

class Card {
  Card({
    this.id,
    this.physicalCard,
    this.last4Digits,
    this.status,
    this.cardNumber,
    this.expirationDate,
    this.cvv,
  });

  String? id;
  bool? physicalCard;
  String? last4Digits;
  String? status;
  String? cardNumber;
  String? expirationDate;
  String? cvv;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"],
        physicalCard: json["physical_card"],
        last4Digits: json["last_4_digits"],
        status: json["status"],
        cardNumber: json["card_number"],
        expirationDate: json["expiration_date"],
        cvv: json["cvv"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "physical_card": physicalCard,
        "last_4_digits": last4Digits,
        "status": status,
        "card_number": cardNumber,
        "expiration_date": expirationDate,
        "cvv": cvv,
      };
}

class CashAdvance {
  CashAdvance({
    this.apr,
    this.limit,
    this.eligible,
  });

  String? apr;
  int? limit;
  bool? eligible;

  factory CashAdvance.fromJson(Map<String, dynamic> json) => CashAdvance(
        apr: json["apr"],
        limit: json["limit"],
        eligible: json["eligible"],
      );

  Map<String, dynamic> toJson() => {
        "apr": apr,
        "limit": limit,
        "eligible": eligible,
      };
}
