class EligibleAccountsModel {
  EligibleAccountsModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String status;
  late final String message;

  EligibleAccountsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.glorifiAccounts,
    required this.linkedAccounts,
  });
  late final List<GlorifiAccounts> glorifiAccounts;
  late final List<LinkedAccounts> linkedAccounts;

  Data.fromJson(Map<String, dynamic> json) {
    glorifiAccounts = List.from(json['glorifiAccounts'])
        .map((e) => GlorifiAccounts.fromJson(e))
        .toList();
    linkedAccounts = List.from(json['linkedAccounts'])
        .map((e) => LinkedAccounts.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['glorifiAccounts'] = glorifiAccounts.map((e) => e.toJson()).toList();
    _data['linkedAccounts'] = linkedAccounts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class GlorifiAccounts {
  GlorifiAccounts({
    required this.accountNumber,
    required this.routingNumber,
    required this.accountName,
    required this.type,
    required this.currentBalance,
    required this.isoCurrencyCode,
    required this.apy,
    required this.interestRate,
    required this.term,
    required this.bankAccountId,
    required this.coreAccountId,
  });
  late final String accountNumber;
  late final String routingNumber;
  late final String accountName;
  late final String type;
  late final String currentBalance;
  late final String isoCurrencyCode;
  late final String apy;
  late final String interestRate;
  late final String term;
  late final String bankAccountId;
  late final String coreAccountId;

  GlorifiAccounts.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    accountName = json['account_name'];
    type = json['type'];
    currentBalance = json['current_balance'];
    isoCurrencyCode = json['iso_currency_code'];
    apy = json['apy'];
    interestRate = json['interest_rate'];
    term = json['term'];
    bankAccountId = json['bankAccountId'];
    coreAccountId = json['coreAccountId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_number'] = accountNumber;
    _data['routing_number'] = routingNumber;
    _data['account_name'] = accountName;
    _data['type'] = type;
    _data['current_balance'] = currentBalance;
    _data['iso_currency_code'] = isoCurrencyCode;
    _data['apy'] = apy;
    _data['interest_rate'] = interestRate;
    _data['term'] = term;
    _data['bankAccountId'] = bankAccountId;
    _data['coreAccountId'] = coreAccountId;
    return _data;
  }
}

class LinkedAccounts {
  LinkedAccounts({
    required this.id,
    required this.name,
    required this.mask,
    required this.balance,
    required this.isoCurrencyCode,
    required this.institution,
    required this.status,
  });
  late final String id;
  late final String name;
  late final String mask;
  late final double? balance;
  late final String isoCurrencyCode;
  late final String institution;
  late final String status;

  LinkedAccounts.fromJson(Map<String, dynamic> json) {
    id = json['_Id'];
    name = json['name'];
    mask = json['mask'];
    balance = json['balance'];
    isoCurrencyCode = json['iso_currency_code'];
    institution = json['institution'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_Id'] = id;
    _data['name'] = name;
    _data['mask'] = mask;
    _data['balance'] = balance;
    _data['iso_currency_code'] = isoCurrencyCode;
    _data['institution'] = institution;
    _data['status'] = status;
    return _data;
  }
}
