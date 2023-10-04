import 'package:intl/intl.dart';

class ConnectedAccountModel {
  ConnectedAccountModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String status;
  late final String message;

  ConnectedAccountModel.fromJson(Map<String, dynamic> json) {
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
    required this.accounts,
  });
  late final List<AccountsData> accounts;

  Data.fromJson(Map<String, dynamic> json) {
    accounts = List.from(json['accounts'])
        .map((e) => AccountsData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accounts'] = accounts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AccountsData {
  AccountsData({
    required this.plaidAccountId,
    required this.name,
    required this.mask,
    required this.officialName,
    required this.currentBalance,
    this.availableBalance,
    required this.isoCurrencyCode,
    this.limit,
    this.unofficialCurrencyCode,
    required this.type,
    required this.subtype,
    this.plaidInstitutionId,
  });
  late final String plaidAccountId;
  late final String name;
  late final String mask;
  late final String officialName;
  late final double currentBalance;
  late final String? availableBalance;
  late final String isoCurrencyCode;
  late final Null limit;
  late final Null unofficialCurrencyCode;
  late final String type;
  late final String subtype;
  late final Null plaidInstitutionId;

  String getCurrentBalance() {
    double d = currentBalance;
    var format =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: "\$");
    String parsedCurrentBalance = format.format(d);
    return parsedCurrentBalance;
  }

  AccountsData.fromJson(Map<String, dynamic> json) {
    plaidAccountId = json['plaid_account_id'];
    name = json['name'] ?? "";
    mask = json['mask'] ?? "";
    officialName = json['official_name'] ?? "";
    currentBalance = json['current_balance'] ?? "";
    availableBalance = null;
    isoCurrencyCode = json['iso_currency_code'] ?? "";
    limit = null;
    unofficialCurrencyCode = null;
    type = json['type'] ?? "";
    subtype = json['subtype'] ?? "";
    plaidInstitutionId = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['plaid_account_id'] = plaidAccountId;
    _data['name'] = name;
    _data['mask'] = mask;
    _data['official_name'] = officialName;
    _data['current_balance'] = currentBalance;
    _data['available_balance'] = availableBalance;
    _data['iso_currency_code'] = isoCurrencyCode;
    _data['limit'] = limit;
    _data['unofficial_currency_code'] = unofficialCurrencyCode;
    _data['type'] = type;
    _data['subtype'] = subtype;
    _data['plaid_institution_id'] = plaidInstitutionId;
    return _data;
  }
}
