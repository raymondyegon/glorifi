class EBSTransactions {
  int returned;
  int total;
  List<EBSTransaction> items;

  EBSTransactions(
      {required this.returned, required this.total, this.items = const []});

  factory EBSTransactions.fromJson(Map<String, dynamic> json) {
    List<EBSTransaction> _list = [];
    if (json['transactions'] != null) {
      _list.addAll((json['transactions'] as List)
          .map((d) => EBSTransaction.fromJson(d))
          .toList());
    }
    return EBSTransactions(
      returned: json['returned'],
      total: json['total'],
      items: _list,
    );
  }

  static EBSTransactions empty() {
    return EBSTransactions(
      returned: 0,
      total: 0,
    );
  }
}

class EBSTransaction {
  String merchant;
  double amount;
  String status;
  String type;
  String description;
  double? endingBalance;
  DateTime transactionDate;
  DateTime? postedDate;
  String transactionStatus;
  String transactionPosn;

  bool get isPending => transactionStatus.toLowerCase() == 'pending';

  EBSTransaction({
    required this.merchant,
    required this.amount,
    required this.status,
    required this.type,
    required this.description,
      this.endingBalance,
    required this.transactionDate,
    this.postedDate,
      required this.transactionStatus,
      required this.transactionPosn
  });

  factory EBSTransaction.fromJson(Map<String, dynamic> json) => EBSTransaction(
        merchant: json['trnMerchant'],
      amount: double.tryParse(json['trnAmt'].toString()) ?? 0.0,
        status: json['trnStatus'],
        type: json['trnType'],
        description: json['trnDesc'],
      endingBalance: json['trnEndingBalance'] != '' ? json['trnEndingBalance'] : null,
        transactionDate: DateTime.parse(json['trnDate']),
      transactionStatus: json['trnStatus'],
      transactionPosn: json['trnPosn']);
  
}
