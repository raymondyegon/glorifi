import 'package:glorifi/src/feature/insurance/model/insurance_data_model.dart';

class BaseResponse {
  BaseResponse({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final int success;
  late final MyPolicyHeaderResponse data;
  late final String status;
  late final String message;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = MyPolicyHeaderResponse.fromJson(json['data']);
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
