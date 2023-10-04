class EnableCreditScoreModel {
  late String ipAddress;
  late Identity identity;

  EnableCreditScoreModel({required this.ipAddress, required this.identity});

  EnableCreditScoreModel.fromJson(Map<String, dynamic> json) {
    ipAddress = json['ipAddress'];
    identity = Identity.fromJson(json['identity']);
  }

  factory EnableCreditScoreModel.empty() => EnableCreditScoreModel(
        identity: Identity(
            name: Name(
              middleName: '',
              secondLastName: '',
            ),
            dateOfBirth: DateOfBirth(),
            address: [
              Address(
                addressLine1: '',
                addressLine2: '',
                addressType: 'Current',
                city: '',
                region: '',
                regionFullName: '',
                countryCode: 'US',
                postalCode: '',
                postalIdentifier: 'postalIdentifier',
                county: '',
                isPrimary: 'true',
              )
            ],
            governmentId: GovernmentId(
              documentType: 'SSN',
              value: '',
            ),
            phone: [
              Phone(
                countryCode: '1',
                area: '',
                type: 'Mobile',
                isPrimary: 'true',
              ),
            ],
            email: [
              Email(
                emailType: 'Personal',
              ),
            ]),
        ipAddress: '',
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ipAddress'] = ipAddress;
    data['identity'] = identity.toJson();
    return data;
  }
}

class Identity {
  late Name name;
  late List<Address> address;
  late DateOfBirth dateOfBirth;
  late GovernmentId governmentId;
  late List<Phone> phone;
  late List<Email> email;

  Identity({
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.governmentId,
    required this.phone,
    required this.email,
  });

  Identity.fromJson(Map<String, dynamic> json) {
    name = Name.fromJson(json['name']);
    address = <Address>[];
    json['address'].forEach((v) {
      address.add(Address.fromJson(v));
    });
    dateOfBirth = DateOfBirth.fromJson(json['dateOfBirth']);
    governmentId = GovernmentId.fromJson(json['governmentId']);

    phone = <Phone>[];
    json['phone'].forEach((v) {
      phone.add(Phone.fromJson(v));
    });
    email = <Email>[];
    json['email'].forEach((v) {
      email.add(Email.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name.toJson();
    data['address'] = address.map((v) => v.toJson()).toList();
    data['dateOfBirth'] = dateOfBirth.toJson();
    data['governmentId'] = governmentId.toJson();
    data['phone'] = phone.map((v) => v.toJson()).toList();
    data['email'] = email.map((v) => v.toJson()).toList();

    return data;
  }
}

class Name {
  String? firstName;
  String? middleName;
  String? lastName;
  String? secondLastName;

  Name({this.firstName, this.middleName, this.lastName, this.secondLastName});

  Name.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    secondLastName = json['secondLastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['secondLastName'] = secondLastName;
    return data;
  }
}

class Address {
  String? addressType;
  String? countryCode;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? county;
  String? region;
  String? regionFullName;
  String? postalCode;
  String? postalIdentifier;
  String? isPrimary;

  Address({
    this.addressType,
    this.countryCode,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.county,
    this.region,
    this.postalCode,
    this.postalIdentifier,
    this.isPrimary,
    this.regionFullName,
  });

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    countryCode = json['countryCode'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    county = json['county'];
    region = json['region'];
    postalCode = json['postalCode'];
    postalIdentifier = json['postalIdentifier'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['addressType'] = addressType;
    data['countryCode'] = countryCode;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['county'] = county;
    data['region'] = region;
    data['postalCode'] = postalCode;
    data['postalIdentifier'] = postalIdentifier;
    data['isPrimary'] = isPrimary;
    return data;
  }
}

class DateOfBirth {
  String? day;
  String? month;
  String? year;

  DateOfBirth({this.day, this.month, this.year});

  DateOfBirth.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}

class GovernmentId {
  String? documentType;
  String? value;

  GovernmentId({this.documentType, this.value});

  GovernmentId.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['documentType'] = documentType;
    data['value'] = value;
    return data;
  }
}

class Phone {
  String? countryCode;
  String? area;
  String? number;
  String? type;
  String? isPrimary;

  Phone({this.countryCode, this.area, this.number, this.type, this.isPrimary});

  Phone.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    area = json['area'];
    number = json['number'];
    type = json['type'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['area'] = data['number'] = number;
    data['type'] = type;
    data['isPrimary'] = isPrimary;
    return data;
  }
}

class Email {
  String? email;
  String? emailType;

  Email({this.email, this.emailType});

  Email.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailType = json['emailType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['emailType'] = emailType;
    return data;
  }
}
