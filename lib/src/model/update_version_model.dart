import 'dart:convert';

class UpdateVersionModel {
  UpdateVersionModel({
    required this.lastMandatoryVersion,
    required this.lastOptionalVersion,
  });

  String lastMandatoryVersion;
  String lastOptionalVersion;

  factory UpdateVersionModel.fromRawJson(String str) =>
      UpdateVersionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateVersionModel.fromJson(Map<String, dynamic> json) =>
      UpdateVersionModel(
        lastMandatoryVersion: json["lastMandatoryVersion"],
        lastOptionalVersion: json["lastOptionalVersion"],
      );

  Map<String, dynamic> toJson() => {
        "lastMandatoryVersion": lastMandatoryVersion,
        "lastOptionalVersion": lastOptionalVersion,
      };
}
