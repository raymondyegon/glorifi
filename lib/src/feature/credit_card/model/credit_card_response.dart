class CreditCardResponse {
  CreditCardResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final List<ExternalCreditCardData> data;
  late final String status;
  late final String message;

  CreditCardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data'])
        .map((e) => ExternalCreditCardData.fromJson(e))
        .toList();
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class ExternalCreditCardData {
  ExternalCreditCardData({
    required this.name,
    required this.maskedNumbers,
    required this.fullName,
    required this.currentBalance,
  });
  late final String name;
  late final String maskedNumbers;
  late final String fullName;
  late final String currentBalance;

  ExternalCreditCardData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    maskedNumbers = json['masked_numbers'];
    fullName = json['full_name'];
    currentBalance = json['current_balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['masked_numbers'] = maskedNumbers;
    _data['full_name'] = fullName;
    _data['current_balance'] = currentBalance;
    return _data;
  }
}
