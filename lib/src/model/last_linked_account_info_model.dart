class LastLinkedAccountInfoModel {
  late String? institutionId;
  late String? institutionName;
  late String? institutionUrl;
  late String? institutionLogo;

  LastLinkedAccountInfoModel({
    this.institutionId,
    this.institutionLogo,
    this.institutionName,
    this.institutionUrl,
  });

  factory LastLinkedAccountInfoModel.fromJson(Map<String, dynamic> json) {
    return LastLinkedAccountInfoModel(
      institutionId: json['institution_id'],
      institutionName: json['institution_name'],
      institutionUrl: json['institution_url'],
      institutionLogo: json['institution_logo'],
    );
  }
}
