import 'package:glorifi/src/feature/policy_detail/model/policy_detail_data.dart';

class PolicyDetailResponse {
  PolicyDetailResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final PolicyDetailData data;
  late final String status;
  late final String message;

  PolicyDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = PolicyDetailData.fromJson(json['data']);
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
