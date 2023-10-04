import 'package:glorifi/src/model/personal_snapshot/single_account_item_model.dart';

class SavingsRetirementModel {
  late final int? cardId;
  late final String? title;
  late final String? description;
  late final double? current;
  late final List<HistoricalItem> historical;

  Accounts accounts = Accounts();

  SavingsRetirementModel(
      {this.cardId,
      this.title,
      this.description,
      this.current,
      this.historical = const [],
      required this.accounts});

  SavingsRetirementModel.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    title = json['title'];
    description = json['description'];
    current = json['current'];
    historical = [];
    if (json['historical'] != '') {
      final historicalApi = json['historical'];
      historicalApi.keys.forEach((key) {
        historical.add(
          HistoricalItem(
            date: DateTime.parse(key),
            value: historicalApi[key],
          ),
        );
      });
    }
    accounts = json['accounts'] != null ? Accounts.fromJson(json['accounts']) : Accounts();
  }
}

class Accounts {
  List<SingleAccountItemModel> employerSponsoredAccounts = [];
  List<SingleAccountItemModel> individualAccounts = [];

  Accounts({
    this.employerSponsoredAccounts = const [],
    this.individualAccounts = const [],
  });

  Accounts.fromJson(Map<String, dynamic> json) {
    employerSponsoredAccounts = <SingleAccountItemModel>[];
    if (json['employer_sponsored_accounts'] != null) {
      json['employer_sponsored_accounts'].forEach((v) {
        employerSponsoredAccounts.add(SingleAccountItemModel.fromJson(v));
      });
    }
    individualAccounts = <SingleAccountItemModel>[];
    if (json['individual_accounts'] != null) {
      json['individual_accounts'].forEach((v) {
        individualAccounts.add(SingleAccountItemModel.fromJson(v));
      });
    }
  }
}

class HistoricalItem {
  final DateTime date;
  final double value;

  HistoricalItem({
    required this.date,
    required this.value,
  });
}
