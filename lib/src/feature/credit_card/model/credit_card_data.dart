class CreditCardData {
  CreditCardData({
    this.data,
  });
  late final DetailData? data;

  CreditCardData.fromJson(Map<String, dynamic> json) {
    data = DetailData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.toJson();
    return _data;
  }
}

class DetailData {
  DetailData({
    required this.progress,
    required this.cardType,
    required this.lastFourCardNumber,
    required this.amount,
    required this.availableAmount,
    required this.paymentDueDate,
    required this.minimumAmountDue,
  });
  late final double progress;
  late final String cardType;
  late final int lastFourCardNumber;
  late final String amount;
  late final String availableAmount;
  late final String paymentDueDate;
  late final String minimumAmountDue;

  DetailData.fromJson(Map<String, dynamic> json) {
    progress = json['progress'];
    cardType = json['cardType'];
    lastFourCardNumber = json['lastFourCardNumber'];
    amount = json['amount'];
    availableAmount = json['availableAmount'];
    paymentDueDate = json['paymentDueDate'];
    minimumAmountDue = json['minimumAmountDue'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['progress'] = progress;
    _data['cardType'] = cardType;
    _data['lastFourCardNumber'] = lastFourCardNumber;
    _data['amount'] = amount;
    _data['availableAmount'] = availableAmount;
    _data['paymentDueDate'] = paymentDueDate;
    _data['minimumAmountDue'] = minimumAmountDue;
    return _data;
  }
}
