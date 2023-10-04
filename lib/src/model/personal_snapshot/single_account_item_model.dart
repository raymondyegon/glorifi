import 'dropdown_account.dart';

class SingleAccountItemModel implements DropDownAccount {
  SingleAccountItemModel({
    required this.label,
    required this.name,
    required this.balance,
    required this.accountId,
  });

  final String label;
  final String name;
  final double balance;
  final String accountId;

  factory SingleAccountItemModel.fromJson(Map<dynamic, dynamic> json) {
    return SingleAccountItemModel(
      label: json['official_name'] ?? "",
      name: json['name'] ?? "",
      balance: json['balance'] ?? 0.0,
      accountId: json['account_id'],
    );
  }

  String get getLabel {
    return label;
  }
}
