class BasicInformationValidationErrorModel {
  BasicInformationValidationErrorModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });

  bool success;
  Data data;
  String status;
  String message;

  factory BasicInformationValidationErrorModel.fromJson(
          Map<String, dynamic> json) =>
      BasicInformationValidationErrorModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class Data {
  Data({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
  });

  List<String>? firstName;
  List<String>? lastName;
  List<String>? dateOfBirth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"] == null
            ? []
            : List<String>.from(json["first_name"].map((x) => x)),
        lastName: json["last_name"] == null
            ? []
            : List<String>.from(json["last_name"].map((x) => x)),
        dateOfBirth: json["date_of_birth"] == null
            ? []
            : List<String>.from(json["date_of_birth"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null
            ? []
            : List<dynamic>.from(firstName!.map((x) => x)),
        "last_name":
            lastName == null ? [] : List<dynamic>.from(lastName!.map((x) => x)),
        "date_of_birth": dateOfBirth == null
            ? []
            : List<dynamic>.from(dateOfBirth!.map((x) => x)),
      };
}

class ContactInformationValidationErrorModel {
  ContactInformationValidationErrorModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });

  bool success;
  Data data;
  String status;
  String message;

  factory ContactInformationValidationErrorModel.fromJson(
          Map<String, dynamic> json) =>
      ContactInformationValidationErrorModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class ContactValidationErrorData {
  ContactValidationErrorData({
    this.email,
    this.phoneNumber,
  });

  List<String>? email;
  List<String>? phoneNumber;

  factory ContactValidationErrorData.fromJson(Map<String, dynamic> json) =>
      ContactValidationErrorData(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"].map((x) => x)),
        phoneNumber: json["phone_number"] == null
            ? []
            : List<String>.from(json["last_name"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "phone_number": phoneNumber == null
            ? []
            : List<dynamic>.from(phoneNumber!.map((x) => x)),
      };
}

class AddressValidationErrorModel {
  AddressValidationErrorModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });

  bool success;
  AddressValidationError data;
  String status;
  String message;

  factory AddressValidationErrorModel.fromJson(Map<String, dynamic> json) =>
      AddressValidationErrorModel(
        success: json["success"],
        data: AddressValidationError.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class AddressValidationError {
  AddressValidationError({
    this.line1,
    this.city,
    this.state,
    this.zip,
  });

  List<String>? line1;
  List<String>? city;
  List<String>? state;
  List<String>? zip;

  factory AddressValidationError.fromJson(Map<String, dynamic> json) =>
      AddressValidationError(
        line1: json["line1"] == null
            ? []
            : List<String>.from(json["line1"].map((x) => x)),
        city: json["city"] == null
            ? []
            : List<String>.from(json["city"].map((x) => x)),
        state: json["state"] == null
            ? []
            : List<String>.from(json["state"].map((x) => x)),
        zip: json["zip"] == null
            ? []
            : List<String>.from(json["zip"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "line1": line1 == null ? [] : List<dynamic>.from(line1!.map((x) => x)),
        "city": city == null ? [] : List<dynamic>.from(city!.map((x) => x)),
        "state": state == null ? [] : List<dynamic>.from(state!.map((x) => x)),
        "zip": zip == null ? [] : List<dynamic>.from(zip!.map((x) => x)),
      };
}

class TokenizationSSNErrorModel {
  TokenizationSSNErrorModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });

  bool success;
  Data data;
  String status;
  String message;

  factory TokenizationSSNErrorModel.fromJson(
      Map<String, dynamic> json) =>
      TokenizationSSNErrorModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class TokenizationSSNErrorData {
  TokenizationSSNErrorData({
    this.value,
  });

  List<String>? value;

  factory TokenizationSSNErrorData.fromJson(Map<String, dynamic> json) =>
      TokenizationSSNErrorData(
        value: json["value"] == null
            ? []
            : List<String>.from(json["value"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x)),
  };
}