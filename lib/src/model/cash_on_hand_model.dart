import 'package:glorifi/src/model/personal_snapshot/single_account_item_model.dart';

class CashOnHandModel {
  bool success = false;
  CashOnHandData? data;
  String? status;
  String? message;

  CashOnHandModel({this.success = false, this.data, this.status, this.message});

  CashOnHandModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    data = json['data'] != null ? CashOnHandData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
}

class CashOnHandData {
  late double totalAmount;
  double? checkingAmount;
  double? savingsAmount;
  double? otherAmount;
  String? title;
  String? description;
  int cardId = 0;
  DateTime? asOfDate;
  List<SingleAccountItemModel> checkingAccounts = const [];
  List<SingleAccountItemModel> savingsAccounts = const [];
  List<SingleAccountItemModel> otherAccounts = const [];

  CashOnHandData({
    this.totalAmount = 0,
    this.checkingAmount,
    this.savingsAmount,
    this.otherAmount,
    this.asOfDate,
    this.checkingAccounts = const [],
    this.savingsAccounts = const [],
    this.otherAccounts = const [],
    this.title,
    required this.cardId,
    this.description,
  });

  CashOnHandData.fromJson(Map<String, dynamic> json) {
    title = json['title'] == "Cash On Hand" ? "Cash on Hand" : json['title'];
    description = json['description'];
    cardId = json['card_id'];
    totalAmount = json['total_amount'].toDouble();
    checkingAmount = json['checking_amount'].toDouble();
    savingsAmount = json['savings_amount'].toDouble();
    otherAmount = json['other_amount'].toDouble();
    asOfDate = DateTime.parse(json['as_of_date']);
    checkingAccounts = <SingleAccountItemModel>[];
    if (json['checking_accounts'] != null) {
      json['checking_accounts'].forEach((v) {
        checkingAccounts.add(SingleAccountItemModel.fromJson(v));
      });
    }
    savingsAccounts = <SingleAccountItemModel>[];
    if (json['savings_accounts'] != null) {
      json['savings_accounts'].forEach((v) {
        savingsAccounts.add(SingleAccountItemModel.fromJson(v));
      });
    }
    otherAccounts = <SingleAccountItemModel>[];
    if (json['other_accounts'] != null) {
      json['other_accounts'].forEach((v) {
        otherAccounts.add(SingleAccountItemModel.fromJson(v));
      });
    }
  }
}
