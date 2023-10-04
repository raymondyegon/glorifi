import 'loyalty.dart';

class LoyaltyResponse {
  final bool success;
  final Loyalty? data;
  final String? status;
  final String? message;

  LoyaltyResponse({
    required this.success,
    this.data,
    this.status,
    this.message,
  });

  factory LoyaltyResponse.fromJson(Map<String, dynamic> json) {
    return LoyaltyResponse(
      success: json['success'],
      data: json['data'] != null ? Loyalty.fromJson(json['data']) : null,
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
