class ProfileUpdateResponse {
  ProfileUpdateResponse({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  ProfileUpdateResponse.fromJson(dynamic json) {
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
    this.id,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
  }

  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }
}
