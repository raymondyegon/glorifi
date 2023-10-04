class EBSStatement {
  String docId;
  DateTime startDate;
  DateTime endDate;
  String accountNumber;

  EBSStatement(
      {required this.docId,
      required this.startDate,
      required this.endDate,
      required this.accountNumber});

  factory EBSStatement.fromJson(Map<String, dynamic> json) {
    return EBSStatement(
      docId: json['docId'],
      startDate: DateTime.parse(json['statementStartDate']),
      endDate: DateTime.parse(json['statementEndDate']),
      accountNumber: json['accountNumber'],
    );
  }
}
