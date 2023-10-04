class InitialEnableCreditScoreResponseModel {
  InitialEnableCreditScoreResponseModel({
    required this.success,
    this.data,
    this.status,
    this.message,
  });

  bool success = false;
  Data? data;
  String? status;
  String? message;

  factory InitialEnableCreditScoreResponseModel.fromJson(Map<String, dynamic> json) =>
      InitialEnableCreditScoreResponseModel(
        success: json["success"] == true,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.decision,
  });

  String? decision;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        decision: json["decision"],
      );

  Map<String, dynamic> toJson() => {
        "decision": decision,
      };
}
