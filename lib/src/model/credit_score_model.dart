class CreditScoreModel {
  bool? success;
  Data? data;
  String? status;
  String? message;

  CreditScoreModel({this.success, this.data, this.status, this.message});

  CreditScoreModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  late int creditScore;
  late String? creditDelta;
  late String creditBucket;
  late DateTime asOfDate;
  late CreditHistory? creditHistory;
  late CreditHistory? creditUtilization;
  late CreditHistory? creditTotal;
  late CreditAccounts? creditAccounts;

  Data(
      {required this.creditScore,
      this.creditDelta,
      required this.creditBucket,
      required this.asOfDate,
      this.creditHistory,
      this.creditUtilization,
      this.creditTotal,
      this.creditAccounts});

  Data.fromJson(Map<String, dynamic> json) {
    creditScore = json['credit_score'];
    creditDelta = json['credit_delta'];
    creditBucket = json['credit_bucket'];
    asOfDate = DateTime.parse(json['as_of_date']);
    creditHistory =
        json['credit_history'] != null ? CreditHistory.fromJson(json['credit_history']) : null;
    creditUtilization = json['credit_utilization'] != null
        ? CreditHistory.fromJson(json['credit_utilization'])
        : null;
    creditTotal =
        json['credit_total'] != null ? CreditHistory.fromJson(json['credit_total']) : null;
    creditAccounts =
        json['credit_accounts'] != null ? CreditAccounts.fromJson(json['credit_accounts']) : null;
  }
}

class CreditHistory {
  late String? value;
  late String? bucket;

  CreditHistory({this.value, this.bucket});

  CreditHistory.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    bucket = json['bucket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['bucket'] = bucket;
    return data;
  }
}

class CreditAccounts {
  late List<OpenAccounts> openAccounts;
  late List<ClosedAccounts> closedAccounts;

  CreditAccounts({this.openAccounts = const [], this.closedAccounts = const []});

  CreditAccounts.fromJson(Map<String, dynamic> json) {
    openAccounts = [];
    if (json['open_accounts'] != null) {
      json['open_accounts'].forEach((v) {
        openAccounts.add(OpenAccounts.fromJson(v));
      });
    }
    closedAccounts = [];
    if (json['closed_accounts'] != null) {
      json['closed_accounts'].forEach((v) {
        closedAccounts.add(ClosedAccounts.fromJson(v));
      });
    }
  }
}

class OpenAccounts {
  late String name;
  late String institution;
  late String mask;
  late double balance;
  late double totalCredit;
  late String creditHistory;
  late String creditUtilization;

  OpenAccounts({
    this.name = '',
    this.institution = '',
    this.mask = '',
    this.balance = 0,
    this.totalCredit = 0,
    this.creditHistory = '',
    this.creditUtilization = '',
  });

  OpenAccounts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    institution = json['institution'];
    mask = json['mask'];
    balance = json['balance'] ?? 0.0;
    totalCredit = json['total_credit'] ?? 0.0;
    creditHistory = json['credit_history'];
    creditUtilization = json['credit_utilization'];
  }
}

class ClosedAccounts {
  late String name;
  late String institution;
  late String mask;

  ClosedAccounts({
    this.name = '',
    this.institution = '',
    this.mask = '',
  });

  ClosedAccounts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    institution = json['institution'];
    mask = json['mask'];
  }
}
