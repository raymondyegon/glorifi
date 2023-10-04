class PlaidModel {
  bool success = false;
  PlaidModelData? data;
  String? status;
  String? message;

  PlaidModel({this.success = false, this.data, this.status, this.message});

  PlaidModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    data = json['data'] != null ? PlaidModelData.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class PlaidModelData {
  String? expiration;
  String? link_token;
  String? request_id;

  PlaidModelData({this.expiration, this.link_token, this.request_id});

  factory PlaidModelData.fromJson(Map<dynamic, dynamic> json) {
    return PlaidModelData(
      expiration: json['expiration'],
      link_token: json['link_token'],
      request_id: json['request_id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = Map<dynamic, dynamic>();
    data['expiration'] = expiration;
    data['link_token'] = link_token;
    data['request_id'] = request_id;
    return data;
  }

  factory PlaidModelData.empty() => PlaidModelData(
        expiration: '',
        link_token: '',
        request_id: '',
      );
}
