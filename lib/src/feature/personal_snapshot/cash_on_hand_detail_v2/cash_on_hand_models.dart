class GetCashOnHandModel {
  GetCashOnHandModel({
    required this.cardId,
    required this.title,
    required this.description,
    required this.asOfDate,
    required this.totalAmount,
    required this.checkingAmount,
    required this.savingsAmount,
    required this.otherAmount,
    required this.checkingAccounts,
    required this.savingsAccounts,
    required this.otherAccounts,
  });
  late final int cardId;
  late final String title;
  late final String description;
  late final String asOfDate;
  late final double totalAmount;
  late final double checkingAmount;
  late final double savingsAmount;
  late final double otherAmount;
  late final List<CheckingAccounts> checkingAccounts;
  late final List<SavingsAccounts> savingsAccounts;
  late final List<dynamic> otherAccounts;

  GetCashOnHandModel.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    title = json['title'];
    description = json['description'];
    asOfDate = json['as_of_date'];
    totalAmount = json['total_amount'];
    checkingAmount = json['checking_amount'];
    savingsAmount = json['savings_amount'];
    otherAmount = double.parse(json['other_amount'].toString());
    checkingAccounts = List.from(json['checking_accounts'])
        .map((e) => CheckingAccounts.fromJson(e))
        .toList();
    savingsAccounts = List.from(json['savings_accounts'])
        .map((e) => SavingsAccounts.fromJson(e))
        .toList();
    otherAccounts = List.castFrom<dynamic, dynamic>(json['other_accounts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['card_id'] = cardId;
    _data['title'] = title;
    _data['description'] = description;
    _data['as_of_date'] = asOfDate;
    _data['total_amount'] = totalAmount;
    _data['checking_amount'] = checkingAmount;
    _data['savings_amount'] = savingsAmount;
    _data['other_amount'] = otherAmount;
    _data['checking_accounts'] =
        checkingAccounts.map((e) => e.toJson()).toList();
    _data['savings_accounts'] = savingsAccounts.map((e) => e.toJson()).toList();
    _data['other_accounts'] = otherAccounts;
    return _data;
  }
}

class CheckingAccounts {
  CheckingAccounts({
    required this.accountId,
    required this.balance,
    required this.name,
    required this.officialName,
  });
  late final String accountId;
  late final double balance;
  late final String name;
  late final String officialName;

  CheckingAccounts.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    balance = json['balance'];
    name = json['name'];
    officialName = json['official_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_id'] = accountId;
    _data['balance'] = balance;
    _data['name'] = name;
    _data['official_name'] = officialName;
    return _data;
  }
}

class SavingsAccounts {
  SavingsAccounts({
    required this.accountId,
    required this.balance,
    required this.name,
    required this.officialName,
  });
  late final String accountId;
  late final double balance;
  late final String name;
  late final String officialName;

  SavingsAccounts.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    balance = json['balance'];
    name = json['name'];
    officialName = json['official_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_id'] = accountId;
    _data['balance'] = balance;
    _data['name'] = name;
    _data['official_name'] = officialName;
    return _data;
  }
}
