class CreateDeserveUserResponseModel {
  CreateDeserveUserResponseModel({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  bool? success;
  List<DeserveUser>? data;
  String? status;
  String? message;

  factory CreateDeserveUserResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateDeserveUserResponseModel(
        success: json["success"],
        data: List<DeserveUser>.from(json["data"].map((x) => DeserveUser.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );
}

class DeserveUser {
  DeserveUser({
    this.id,
    this.tenantId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.otherEmail,
    this.phone,
    this.officePhone,
    this.otherPhone,
    this.fax,
    this.addresses,
    this.preferences,
    this.state,
    this.ssn,
    this.dateOfBirth,
    this.mlaAccount,
    this.annualIncome,
    this.nameOnCard,
    this.appleUserId,
    this.googleUserId,
    this.customerType,
    this.createdAt,
    this.updatedAt,
    this.partnerUserId,
  });

  String? id;
  String? tenantId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? otherEmail;
  String? phone;
  String? officePhone;
  String? otherPhone;
  String? fax;
  List<dynamic>? addresses;
  List<dynamic>? preferences;
  String? state;
  String? ssn;
  DateTime? dateOfBirth;
  bool? mlaAccount;
  int? annualIncome;
  String? nameOnCard;
  dynamic appleUserId;
  dynamic googleUserId;
  String? customerType;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic partnerUserId;

  factory DeserveUser.fromJson(Map<String, dynamic> json) => DeserveUser(
        id: json["id"],
        tenantId: json["tenant_id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        email: json["email"],
        otherEmail: json["other_email"],
        phone: json["phone"],
        officePhone: json["office_phone"],
        otherPhone: json["other_phone"],
        fax: json["fax"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        preferences: List<dynamic>.from(json["preferences"].map((x) => x)),
        state: json["state"],
        ssn: json["ssn"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        mlaAccount: json["mla_account"],
        annualIncome: json["annual_income"],
        nameOnCard: json["name_on_card"],
        appleUserId: json["apple_user_id"],
        googleUserId: json["google_user_id"],
        customerType: json["customer_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        partnerUserId: json["partner_user_id"],
      );
}
