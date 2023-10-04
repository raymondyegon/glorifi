class OAODepositAccount {
  String name;
  String description;
  String type;
  String group;
  String term;
  String apy;
  String interestRate;

  OAODepositAccount(
      {required this.name,
      required this.description,
      required this.type,
      required this.group,
      required this.term,
      required this.apy,
      required this.interestRate});

  factory OAODepositAccount.fromJson(Map<String, dynamic> json) {
    return OAODepositAccount(
        name: json['productName'],
        description: json['productDesc'],
        type: json['productType'],
        group: json['productGroup'],
        term: json['term'],
        apy: json['apy'],
        interestRate: json['interestRate']);
  }

  String accountTypeDisplayString() {
    switch (group) {
      case "DDA":
        return "Checking Account";
      case "SAV":
        return "Savings Account";
      case "CD":
        return "Certificate of Deposit";
      default:
        return "";
    }
  }
}


/*
            "productName": "DDA1001",
            "productDesc": "Consumer Checking",
            "productType": "Deposit",
            "productGroup": "DDA",
            "term": "",
            "apy": "1.00",
            "interestRate": "1.00"
*/