import 'package:intl/intl.dart';

class GlorifiAccountResponse {
  GlorifiAccountResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });

  late final bool success;
  late final Data data;
  late final String status;
  late final String message;

  GlorifiAccountResponse.fromJson(Map<String, dynamic> json) {
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

  static GlorifiAccountResponse get noAccountsResponse =>
      GlorifiAccountResponse(
          success: true,
          data: Data(accounts: []),
          status: 'success',
          message: 'No accounts');
}

class Data {
  Data({
    required this.accounts,
  });

  late final List<GloriFiAccountData> accounts;

  Data.fromJson(Map<String, dynamic> json) {
    accounts = List.from(json['glorifi_accounts'])
        .map((e) => GloriFiAccountData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['glorifi_accounts'] = accounts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class GloriFiAccountData {
  GloriFiAccountData({
    required this.accountNumber,
    required this.accountName,
    required this.type,
    required this.currentBalance,
    required this.isoCurrencyCode,
    required this.apy,
    required this.interestRate,
    required this.term,
  });

  late final String accountNumber;
  late final String accountName;
  late final String type;
  late final double currentBalance;
  late final String isoCurrencyCode;
  late final String apy;
  late final String interestRate;
  late final String term;
  late final String bankAccountId;

  String getType() {
    var result = type.replaceAll(RegExp('(?<!^)(?=[A-Z])'), " ");
    var finalResult = result[0].toUpperCase() + result.substring(1);
    return finalResult;
  }

  GloriFiAccountData.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    type = json['type'];
    currentBalance = double.parse(json['current_balance']);
    isoCurrencyCode = json['iso_currency_code'];
    apy = json['apy'];
    interestRate = json['interest_rate'];
    term = json['term'];
    bankAccountId = json['bankAccountId'];
  }

  String getCurrentBalance() {
    double d = currentBalance;
    var format =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: r"$");
    String parsedCurrentBalance = format.format(d);
    return parsedCurrentBalance;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_number'] = accountNumber;
    _data['account_name'] = accountName;
    _data['type'] = type;
    _data['current_balance'] = currentBalance;
    _data['iso_currency_code'] = isoCurrencyCode;
    _data['apy'] = apy;
    _data['interest_rate'] = interestRate;
    _data['term'] = term;
    _data['bankAccountId'] = bankAccountId;
    return _data;
  }

  String getMaskedNumber() {
    if (accountNumber.length > 4) {
      String lastFourDigits = accountNumber.substring(
          accountNumber.length - 4, accountNumber.length);
      return "*$lastFourDigits";
    } else {
      return "*$accountNumber";
    }
  }
}
