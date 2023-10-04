import 'package:get/get.dart';

class ACCApplicationStatusModel extends GetxService {
  ACCApplicationStatusModel({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  bool? success;
  ApplicationStatusData? data;
  String? status;
  String? message;

  ACCApplicationStatusModel copyWith({
    bool? success,
    ApplicationStatusData? data,
    String? status,
    String? message,
  }) =>
      ACCApplicationStatusModel(
        success: success ?? this.success,
        data: data ?? this.data,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory ACCApplicationStatusModel.fromJson(Map<String, dynamic> json) =>
      ACCApplicationStatusModel(
        success: json["success"],
        data: ApplicationStatusData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}

class ApplicationStatusData {
  ApplicationStatusData({
    this.status,
    this.isCreditApproved,
    this.approvalType,
    this.input,
    this.postUrl,
  });

  String? status;
  bool? isCreditApproved;
  dynamic? approvalType;
  String? input;
  String? postUrl;

  ApplicationStatusData copyWith({
    String? status,
    bool? isCreditApproved,
    dynamic? approvalType,
    String? input,
    String? postUrl,
  }) =>
      ApplicationStatusData(
        status: status ?? this.status,
        isCreditApproved: isCreditApproved ?? this.isCreditApproved,
        approvalType: approvalType ?? this.approvalType,
        input: input ?? this.input,
        postUrl: postUrl ?? this.postUrl,
      );

  factory ApplicationStatusData.fromJson(Map<String, dynamic> json) => ApplicationStatusData(
        status: json["status"],
        isCreditApproved: json["is_credit_approved"],
        approvalType: json["approval_type"],
        input: json["input"],
        postUrl: json["post_url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "is_credit_approved": isCreditApproved,
        "approval_type": approvalType,
        "input": input,
        "post_url": postUrl,
      };
}
