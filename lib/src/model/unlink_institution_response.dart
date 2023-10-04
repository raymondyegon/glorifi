class UnlinkInstitutionResponse {
  bool? success;
  Data? data;
  String? status;
  String? message;

  UnlinkInstitutionResponse({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  UnlinkInstitutionResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  String? message;

  Data({
    this.message,
  });

  Data.fromJson(dynamic json) {
    message = json['message'];
  }
}
