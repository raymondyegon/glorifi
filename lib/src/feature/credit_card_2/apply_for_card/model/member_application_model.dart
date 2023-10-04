import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/string_utils.dart';

class ACCMemberApplicationModel extends GetxService {
  ACCMemberApplicationModel({
    this.demographic,
    this.financialInfo,
    this.additionalInfo,
    this.customerType,
    this.ipAddress,
  });

  Demographic? demographic;
  FinancialInfo? financialInfo;
  AdditionalInfo? additionalInfo;
  String? customerType;
  String? ipAddress;

  ACCMemberApplicationModel copyWith({
    Demographic? demographic,
    FinancialInfo? financialInfo,
    AdditionalInfo? additionalInfo,
    String? customerType,
    String? ipAddress,
  }) =>
      ACCMemberApplicationModel(
        demographic: demographic ?? this.demographic,
        financialInfo: financialInfo ?? this.financialInfo,
        additionalInfo: additionalInfo ?? this.additionalInfo,
        customerType: customerType ?? this.customerType,
        ipAddress: ipAddress ?? this.ipAddress,
      );

  factory ACCMemberApplicationModel.fromJson(Map<String, dynamic> json) =>
      ACCMemberApplicationModel(
        demographic: Demographic.fromJson(json["demographic"]),
        financialInfo: FinancialInfo.fromJson(json["financial_info"]),
        additionalInfo: AdditionalInfo.fromJson(json["additional_info"]),
        customerType: json["customer_type"],
        ipAddress: json["ip_address"],
      );

  Map<String, dynamic> toJsonForUpdateApplicant() => {
        "demographic": demographic?.toJson(),
        "financial_info": financialInfo?.toJson(),
      };

  Map<String, dynamic> toJson() => {
        "demographic": demographic?.toJson(),
        "financial_info": financialInfo?.toJson(),
        "additional_info": additionalInfo?.toJson(),
        "customer_type": customerType,
        "ip_address": ipAddress,
      };
}

class Demographic {
  Demographic({
    this.firstName,
    this.middleName,
    this.lastName,
    this.primaryAddress,
    this.mailingAddress,
    this.ssn,
    this.lastFourSsn,
    this.phoneNumber,
    this.email,
    this.dateOfBirth,
  });

  String? firstName;
  String? middleName;
  String? lastName;
  Address? primaryAddress;
  Address? mailingAddress;
  String? ssn;
  String? lastFourSsn;
  String? phoneNumber;
  String? email;
  DateTime? dateOfBirth;

  Demographic copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    Address? primaryAddress,
    Address? mailingAddress,
    String? ssn,
    String? lastFourSsn,
    String? phoneNumber,
    String? email,
    DateTime? dateOfBirth,
  }) =>
      Demographic(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        primaryAddress: primaryAddress ?? this.primaryAddress,
        mailingAddress: mailingAddress ?? this.mailingAddress,
        ssn: ssn ?? this.ssn,
        lastFourSsn: lastFourSsn ?? this.lastFourSsn,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );

  factory Demographic.fromJson(Map<String, dynamic> json) => Demographic(
        firstName: json["first_name"],
        lastName: json["last_name"],
        primaryAddress: Address.fromJson(json["address"]),
        ssn: json["ssn"],
        lastFourSsn: json["last_four_ssn"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "addresses": [
          primaryAddress?.toJson(),
          mailingAddress?.toJson(),
        ],
        "ssn": ssn,
        "last_four_ssn": lastFourSsn,
        "phone_number": phoneNumber!.replaceAll(RegExp('[^0-9]'), ''),
        "email": email,
        "date_of_birth": dateOfBirth!.toServiceFormat(),
      };

  String get fullName => [firstName, middleName, lastName]
      .where((value) => value != null && value != "")
      .join(" ");

  String get getDisplayFormattedDOB =>
      dateOfBirth!.toDisplayFormat().toString().substring(0, 10);

  String get getDisplayFormattedPhoneNumber =>
      phoneNumber.toString().toPrettyPhoneNumberDisplay();

  String get getDisplayFormattedPermanentAddress {
    var list = [
      primaryAddress!.line1,
      primaryAddress!.city,
      primaryAddress!.state,
      primaryAddress!.zip,
    ];
    list.removeWhere((v) => v == null);
    return list.join(", ");
  }

  String get getDisplayFormattedMailingAddress {
    var list = [
      mailingAddress!.line1,
      mailingAddress!.city,
      mailingAddress!.state,
      mailingAddress!.zip,
    ];
    list.removeWhere((v) => v == null);
    return list.join(", ");
  }
  
  bool get shouldShowMailingAddress {
    return mailingAddress!.line1!.isNotEmpty;
  }
}

class Address {
  Address({
    this.line1,
    this.line2,
    this.city,
    this.zip,
    this.state,
    this.type,
  });

  String? line1;
  String? line2;
  String? city;
  String? zip;
  String? state;
  String? type;

  Address copyWith({
    String? line1,
    String? line2,
    String? city,
    String? zip,
    String? state,
    String? type,
  }) =>
      Address(
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
        city: city ?? this.city,
        zip: zip ?? this.zip,
        state: state ?? this.state,
        type: type ?? this.type,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
        city: json["city"],
        zip: json["zip"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
        "city": city,
        "zip": zip,
        "state": state,
        "type": type,
      };

  String get formatAddress {
    String address;
    if (line2 != null && line2!.isNotEmpty) {
      address = "$line1\n$line2" + "\n$city, $state $zip";
    } else {
      address = "$line1, $city, $state $zip";
    }
    return address;
  }

  @override
  String toString() {
    return 'PartialAddress{line1: $line1, line2: $line2, city: $city, state: $state.value, zip: $zip}';
  }
}

class FinancialInfo {
  FinancialInfo({
    this.employmentStatus,
    this.sourceOfIncome,
    this.incomeType,
    this.income,
    this.expenses,
    this.housingType,
  });

  String? employmentStatus;
  String? sourceOfIncome;
  String? incomeType;
  int? income;
  int? expenses;
  String? housingType;

  FinancialInfo copyWith({
    String? employmentStatus,
    String? sourceOfIncome,
    int? income,
    String? incomeType,
    int? expenses,
    String? housingType,
  }) =>
      FinancialInfo(
        employmentStatus: employmentStatus ?? this.employmentStatus,
        sourceOfIncome: sourceOfIncome ?? this.sourceOfIncome,
        income: income ?? this.income,
        incomeType: incomeType ?? this.incomeType,
        expenses: expenses ?? this.expenses,
        housingType: housingType ?? this.housingType,
      );

  factory FinancialInfo.fromJson(Map<String, dynamic> json) => FinancialInfo(
        employmentStatus: json["employment_status"],
        sourceOfIncome: json["source_of_income"],
        income: json["income"],
        incomeType: json["income_type"],
        expenses: json["expenses"],
        housingType: json["housing_type"],
      );

  Map<String, dynamic> toJson() => {
        "employment_status": employmentStatus,
        "source_of_income": sourceOfIncome,
        "income": income,
        "income_type": incomeType,
        "expenses": expenses,
        "housing_type": housingType,
      };
}

class AdditionalInfo {
  AdditionalInfo({
    this.creditRejectionOverride,
  });

  CreditRejectionOverride? creditRejectionOverride;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        creditRejectionOverride:
            CreditRejectionOverride.fromJson(json["credit_rejection_override"]),
      );

  Map<String, dynamic> toJson() => {
        "credit_rejection_override": creditRejectionOverride?.toJson(),
      };
}

class CreditRejectionOverride {
  CreditRejectionOverride({
    this.creditLine,
    this.pricingRate,
  });

  int? creditLine;
  double? pricingRate;

  factory CreditRejectionOverride.fromJson(Map<String, dynamic> json) =>
      CreditRejectionOverride(
        creditLine: json["credit_line"],
        pricingRate: json["pricing_rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "credit_line": creditLine,
        "pricing_rate": pricingRate,
      };
}
