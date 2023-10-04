class EditComparisonModel {
  bool? success;
  String? status;
  String? message;

  EditComparisonModel({this.success, this.status, this.message});

  EditComparisonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
