import 'package:glorifi/src/feature/onboard/create_profile_plus/model/set_password_data.dart';


class SetPasswordResponse {
  bool? _success;
  SetPasswordData? _data;
  String? _status;
  String? _message;

  bool? get success => _success;

  SetPasswordData? get data => _data;

  String? get status => _status;

  String? get message => _message;

  SetPasswordResponse({
    bool? success,
    SetPasswordData? data,
    String? status,
    String? message,
  }) {
    _success = success;
    _data = data;
    _status = status;
    _message = message;
  }

  SetPasswordResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _data =
        json['data'] != null ? SetPasswordData.fromJson(json['data']) : null;
    _status = json['status'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
