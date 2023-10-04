import 'package:glorifi/src/utils/glorifi_assets.dart';

class CCTransactionModel {
  final String merchant;
  final String? icon;
  final double amount;
  final bool isPending;
  final DateTime date;
  final String? logoUrl;
  final double? tip_amount;
  final String? pos_type;
  final String? merchantId;

  CCTransactionModel(
      {required this.merchant,
      this.icon,
      required this.amount,
      required this.date,
      this.logoUrl,
      this.isPending: false,
      this.tip_amount,
      this.pos_type,
      this.merchantId});

  factory CCTransactionModel.fromJson(Map<String, dynamic> json) {
    String? icon(String? code) {
      if (code == null) {
        return null;
      }
      switch (code.toLowerCase()) {
        case "self_love":
          return GlorifiAssets.icecream;
        case "health":
          return GlorifiAssets.doctor;
        case "commuting":
          return GlorifiAssets.car;
        case "rewards":
          return GlorifiAssets.rewards;
        case "dining":
          return GlorifiAssets.utensils;
        case "payment":
          return GlorifiAssets.dollarCircle;
        case "bank_account":
          return GlorifiAssets.twoCards;
        case "interest":
          return GlorifiAssets.stock;
        case "late_fee":
          return GlorifiAssets.alertCircle;
        case "food":
          return GlorifiAssets.food;
        case "other":
          return GlorifiAssets.other;
        case "entertainment":
          return GlorifiAssets.film;
        case "education":
          return GlorifiAssets.book;
        case "shopping":
          return GlorifiAssets.tag;
        case "vacation":
          return GlorifiAssets.plane;
        case "bill":
          return GlorifiAssets.statement;
        case "groceries":
          return GlorifiAssets.shopping;
        default:
          return null;
      }
    }

    return CCTransactionModel(
        amount: json["amount"],
        icon: icon(json['network_data']['merchant_category_code']),
        merchant: json['network_data']['merchant_name'],
        date: DateTime.parse(json['transacted_at']),
        isPending: json['status'] == "pending",
        logoUrl: json['network_data']["logo_url"],
        tip_amount: json['tip_amount'] ?? 0.0,
        pos_type: json['pos_type'] ?? "Online",
      merchantId: json['merchant_id']
    );
  }
}
