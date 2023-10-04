class CCFundingAccountModel {
  late String accountNumber;
  late String routingNumber;
  late String bankName;
  late String accountType;
  late String name;
  late double balance;
  late String lastFourDigits;

  CCFundingAccountModel({
    required this.accountType,
    required this.accountNumber,
    required this.routingNumber,
    required this.bankName,
    required this.name,
    required this.balance,
    required this.lastFourDigits,
  });

  CCFundingAccountModel.fromJson(Map<String, dynamic> json) {
    accountType = json['account_type'];
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    bankName = json['bank_name'];
    name = json['name'];
    balance = json['balance'];
    lastFourDigits = json['lastFourDigits'];
  }
}
