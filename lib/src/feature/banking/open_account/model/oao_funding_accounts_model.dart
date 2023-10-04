import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';

class OAOFundingAccountsModel {
  late List<FundingGlorifiAccount> glorifiAccounts = [];
  late List<FundingLinkedAccountModel> linkedAccounts = [];

  late List<FundingGlorifiAccount> glorifiAccountsDisabled = [];
  late List<FundingLinkedAccountModel> linkedAccountsDisabled = [];
  late DateTime updated = DateTime.now();
  late int numberDisabledAccounts;


  OAOFundingAccountsModel.fromJson(Map<String, dynamic> json, bool isCD) {
    glorifiAccounts = <FundingGlorifiAccount>[];
    if (json['glorifiAccounts'] != null) {
      json['glorifiAccounts'].forEach((v) {
        glorifiAccounts.add(FundingGlorifiAccount.fromJson(v, isCD));
      });
    }
    linkedAccounts = <FundingLinkedAccountModel>[];
    if (json['linkedAccounts'] != null) {
      json['linkedAccounts'].forEach((v) {
        linkedAccounts.add(FundingLinkedAccountModel.fromJson(v, isCD));
      });
    }
    numberDisabledAccounts = linkedAccounts.where((e) => e.disabled == true).length +
        glorifiAccounts.where((element) => element.disabled == true).length;
    updated = DateTime.now();
  }
}

class FundingGlorifiAccount {
  late final String accountNumber;
  String? routingNumber;
  String? accountName;
  String? type;
  late final double balance;
  String? isoCurrencyCode;
  String? apy;
  String? interestRate;
  String? term;
  late final String bankAccountId;
  late final String coreAccountId;
  late final bool disabled;

  FundingGlorifiAccount(
      {required this.accountNumber,
      this.routingNumber,
      this.accountName,
      this.type,
      this.balance: 0,
      this.isoCurrencyCode,
      this.apy,
      this.interestRate,
      this.term,
      this.disabled: false,
      required this.bankAccountId,
      required this.coreAccountId});

  FundingGlorifiAccount.fromJson(Map<String, dynamic> json, bool isCD) {
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    accountName = json['account_name'];
    type = json['type'];
    balance = json['current_balance'] != null ? double.parse(json['current_balance']) : 0;
    isoCurrencyCode = json['iso_currency_code'];
    apy = json['apy'];
    interestRate = json['interest_rate'];
    term = json['term'];
    bankAccountId = json['bankAccountId'];
    coreAccountId = json['coreAccountId'];
    disabled = isCD && balance < minCDDeposit;
  }
}

class FundingLinkedAccountModel {
  late final String id;
  late final String? name;
  late final String? mask;
  late final String? institution;
  late final String? status;
  late double balance;
  late final bool disabled;


  FundingLinkedAccountModel({
    required this.id,
    this.name,
    this.mask,
    this.institution,
    this.status,
    this.balance = 0,
    this.disabled: false,
  });

  FundingLinkedAccountModel.fromJson(Map<String, dynamic> json, bool isCD) {
    id = json['_Id'];
    name = json['name'];
    mask = json['mask'];
    institution = json['institution'];
    status = json['status'];
    balance = json['balance'] != null ? json['balance'] : 0;
    disabled = (isCD && balance < minCDDeposit) || json['status'] != "1";

  }
}
