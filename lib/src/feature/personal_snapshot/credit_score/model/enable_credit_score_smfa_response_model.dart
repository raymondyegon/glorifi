class EnableCreditScoreSmfaResponseModel {
  EnableCreditScoreSmfaResponseModel({
    required this.success,
    this.data,
    this.status,
    this.message,
  });

  bool success = false;
  Data? data;
  String? status;
  String? message;

  factory EnableCreditScoreSmfaResponseModel.fromJson(Map<String, dynamic> json) =>
      EnableCreditScoreSmfaResponseModel(
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
    this.instaTouch,
  });

  String? instaTouch;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        instaTouch: json["instaTouch"],
      );

  Map<String, dynamic> toJson() => {
        "instaTouch": instaTouch,
      };
}
