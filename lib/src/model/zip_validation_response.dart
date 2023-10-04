class ZipValidationResponse {
  ZipValidationResponse({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  ZipValidationResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  bool? success;
  Data? data;
  String? status;
  String? message;

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

class Data {
  Data({
    this.isValid,
  });

  Data.fromJson(dynamic json) {
    isValid = json['is-valid'];
  }

  String? isValid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is-valid'] = isValid;
    return map;
  }
}
