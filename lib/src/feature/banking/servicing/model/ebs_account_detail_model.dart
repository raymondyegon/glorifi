class EBSAccountDetailModel {
  String? accountId;
  String accountType;
  String accountNumber;
  String routingNumber;
  double availableBalance;
  String accountStatus;
  String cardToken;
  List cardArt;
  String cardMarqetaRef;
  String cardStatus;
  String cardLastFour;
  String cardId;
  String interestRate;
  String apy;
  String accruedInterest;
  String? posnId;
 

  EBSAccountDetailModel({
    required this.accountType,
    required this.accountNumber,
    required this.routingNumber,
    required this.availableBalance,
    required this.accountStatus,
    required this.cardToken,
    required this.cardArt,
    required this.cardMarqetaRef,
    required this.cardStatus,
    required this.cardLastFour,
    required this.cardId,
    required this.interestRate,
    required this.apy,
    required this.accruedInterest,
      this.posnId,
      this.accountId
  });

  factory EBSAccountDetailModel.fromJson(Map<String, dynamic> json) {
    return EBSAccountDetailModel(
      accountType: json['acctType'],
      accountNumber: json['acctNumber'],
      routingNumber: json['routingNumber'],
      availableBalance: json['availableBalance'] is double ? json['availableBalance'] : 0.0,
      accountStatus: json['acctStatus'],
      cardToken: json['cardToken'],
      cardArt: (json['cardArt'] is List) ? (json['cardArt'] as List).map((s) => s.toString()).toList() : [],
      cardMarqetaRef: json['cardMarqetaRef'],
      cardStatus: json['cardStatus'],
      cardLastFour: json['cardLastFour'],
      cardId: json['cardId'],
      interestRate: json['interestRate'],
      apy: json['apy'],
      accruedInterest: json['accruedInterest'],
      posnId: json['posnId'],
      accountId: json['acctId'],
    );
  }

  static EBSAccountDetailModel empty() {
    return EBSAccountDetailModel(
      accountType: '',
      accountNumber: '',
      routingNumber: '',
      availableBalance: 0,
      accountStatus: '',
      cardToken: '',
      cardArt: [],
      cardMarqetaRef: '',
      cardStatus: '',
      cardLastFour: '',
      cardId: '',
      interestRate: '',
      apy: '',
      accruedInterest: '',
    );
  }

  String accountStatusDisplayString() {
    switch (accountStatus) {
      case "1":
        return "Active";
      case "2":
        return "Suspended";
      case "3":
        return "Closed";
      default:
        return '';
    }
  }
}
