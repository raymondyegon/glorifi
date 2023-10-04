import 'package:glorifi/src/feature/insurance/model/quote_header_response.dart';

class QuoteResponse {
  QuoteResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final QuoteHeaderResponse data;
  late final String status;
  late final String message;

  QuoteResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = QuoteHeaderResponse.fromJson(json['data']);
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
}
