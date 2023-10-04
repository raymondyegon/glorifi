class UserModel {
  UserModel({
    required this.nameFirst,
    this.nameLast,
    this.preferredName = "",
    this.emailAddress,
    this.phoneNumber,
    this.birthDate,
    this.addressLine1,
    this.addressLine2,
    this.addressCity,
    this.addressState,
    this.addressPostalCode,
    this.addressCountryCode,
    this.id,
    this.memberStatus,
    this.memberKycEvaluationToken,
    this.memberKycEntityToken,
    this.joiningTimestamp,
    this.oktaId,
    this.oktaLogin,
    this.oktaEmail,
    this.memberId,
    this.tier,
  });

  String nameFirst;
  String? nameLast;
  String preferredName;
  String? emailAddress;
  String? phoneNumber;
  DateTime? birthDate;
  String? addressLine1;
  String? addressLine2;
  String? addressCity;
  String? addressState;
  String? addressPostalCode;
  String? addressCountryCode;
  String? id;
  String? memberStatus;
  String? memberKycEvaluationToken;
  String? memberKycEntityToken;
  int? joiningTimestamp;
  String? oktaId;
  String? oktaLogin;
  String? oktaEmail;
  int? memberId;
  String? tier;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        nameFirst: json["name_first"],
        nameLast: json["name_last"],
        preferredName: json["preferred_name"] ?? json["name_first"] ?? "",
        emailAddress: json["email_address"],
        phoneNumber: json["phone_number"],
        birthDate: DateTime.parse(json["birth_date"]),
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        addressCity: json["address_city"],
        addressState: json["address_state"],
        addressPostalCode: json["address_postal_code"],
        addressCountryCode: json["address_country_code"],
        id: json["id"],
        memberStatus: json["member_status"],
        memberKycEvaluationToken: json["member_kyc_evaluation_token"],
        memberKycEntityToken: json["member_kyc_entity_token"],
        joiningTimestamp: json["joining_timestamp"],
        oktaId: json["okta_id"],
        oktaLogin: json["okta_login"],
        oktaEmail: json["okta_email"],
        memberId: json["member_id"],
        tier: json["tier"],
      );

  Map<String, dynamic> toJson() => {
        "name_first": nameFirst,
        "name_last": nameLast,
        "preferred_name": preferredName,
        "email_address": emailAddress,
        "phone_number": phoneNumber,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "address_city": addressCity,
        "address_state": addressState,
        "address_postal_code": addressPostalCode,
        "address_country_code": addressCountryCode,
        "id": id,
        "member_status": memberStatus,
        "member_kyc_evaluation_token": memberKycEvaluationToken,
        "member_kyc_entity_token": memberKycEntityToken,
        "joining_timestamp": joiningTimestamp,
        "okta_id": oktaId,
        "okta_login": oktaLogin,
        "okta_email": oktaEmail,
        "member_id": memberId,
        "tier": tier,
      };
}
