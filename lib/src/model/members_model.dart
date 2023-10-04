class MembersModels {
  bool? success;
  List<Data>? data;
  String? status;
  String? message;

  MembersModels({this.success, this.data, this.status, this.message});

  MembersModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? nameFirst;
  String? nameLast;
  String? emailAddress;
  String? phoneNumber;
  String? birthDate;
  String? addressLine1;
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
  String? profilePicture;
  String? completionPercentage;
  String? preferredName;
  bool? verifiedPhoneNumber;
  String? sRid;
  String? sSelf;
  String? sEtag;
  int? iTs;
  String? tier;

  Data(
      {this.nameFirst,
      this.nameLast,
      this.emailAddress,
      this.phoneNumber,
      this.birthDate,
      this.addressLine1,
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
      this.profilePicture,
      this.completionPercentage,
      this.preferredName,
      this.verifiedPhoneNumber,
      this.sRid,
      this.sSelf,
      this.sEtag,
      this.iTs,
      this.tier});

  Data.fromJson(Map<String, dynamic> json) {
    nameFirst = json['name_first'];
    nameLast = json['name_last'];
    emailAddress = json['email_address'];
    phoneNumber = json['phone_number'];
    birthDate = json['birth_date'];
    addressLine1 = json['address_line_1'];
    addressCity = json['address_city'];
    addressState = json['address_state'];
    addressPostalCode = json['address_postal_code'];
    addressCountryCode = json['address_country_code'];
    id = json['id'];
    memberStatus = json['member_status'];
    memberKycEvaluationToken = json['member_kyc_evaluation_token'];
    memberKycEntityToken = json['member_kyc_entity_token'];
    joiningTimestamp = DateTime.parse(json['joining_timestamp']).millisecondsSinceEpoch;
    oktaId = json['okta_id'];
    oktaLogin = json['okta_login'];
    oktaEmail = json['okta_email'];
    memberId = json['member_id'];
    profilePicture = json['profile_picture'];
    completionPercentage = json['completion_percentage'];
    preferredName = json['preferred_name'];
    verifiedPhoneNumber = json['verified_phone_number'];
    sRid = json['_rid'];
    sSelf = json['_self'];
    sEtag = json['_etag'];
    iTs = json['_ts'];
    tier = json['tier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name_first'] = nameFirst;
    data['name_last'] = nameLast;
    data['email_address'] = emailAddress;
    data['phone_number'] = phoneNumber;
    data['birth_date'] = birthDate;
    data['address_line_1'] = addressLine1;
    data['address_city'] = addressCity;
    data['address_state'] = addressState;
    data['address_postal_code'] = addressPostalCode;
    data['address_country_code'] = addressCountryCode;
    data['id'] = id;
    data['member_status'] = memberStatus;
    data['member_kyc_evaluation_token'] = memberKycEvaluationToken;
    data['member_kyc_entity_token'] = memberKycEntityToken;
    data['joining_timestamp'] = joiningTimestamp;
    data['okta_id'] = oktaId;
    data['okta_login'] = oktaLogin;
    data['okta_email'] = oktaEmail;
    data['member_id'] = memberId;
    data['profile_picture'] = profilePicture;
    data['completion_percentage'] = completionPercentage;
    data['preferred_name'] = preferredName;
    data['verified_phone_number'] = verifiedPhoneNumber;
    data['_rid'] = sRid;
    data['_self'] = sSelf;
    data['_etag'] = sEtag;
    data['_ts'] = iTs;
    data['tier'] = tier;
    return data;
  }
}
