import 'package:glorifi/src/core/logger.dart';

class ProfileModel {
  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.joinDate,
    required this.birthDate,
    this.email,
    required this.zip,
    required this.phoneNumber,
    required this.creditScoreEnabled,
    this.externalAccounts = const [],
    this.middleName,
    this.preferredName,
    this.memberId,
    this.profilePicture,
  });

  String firstName;
  String lastName;
  String? middleName;
  String? preferredName;
  DateTime joinDate;
  DateTime birthDate;
  String? email;
  List<ExternalAccount> externalAccounts;

  // TODO: This is not really optional
  String? memberId;
  String phoneNumber;
  String? profilePicture;
  String zip;
  bool? creditScoreEnabled;

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? middleName,
    String? preferredName,
    DateTime? joinDate,
    DateTime? birthDate,
    String? email,
    String? memberId,
    String? phoneNumber,
    String? profilePicture,
    String? zip,
    bool? creditScoreEnabled,
    List<ExternalAccount>? externalAccounts,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      preferredName: preferredName ?? this.preferredName,
      joinDate: joinDate ?? this.joinDate,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      memberId: memberId ?? this.memberId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      zip: zip ?? this.zip,
      creditScoreEnabled: creditScoreEnabled ?? this.creditScoreEnabled,
      externalAccounts: externalAccounts ?? this.externalAccounts,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    String _getSubString(String str) {
      String returnResult = "";
      try {
        returnResult = str.substring(2, str.length - 1);
      } catch (e) {
        Log.debug(e);
      }
      return returnResult;
    }

    return ProfileModel(
      firstName: json["firstName"],
      lastName: json["lastName"],
      middleName: json["name_middle"],
      preferredName: json["preferred_name"],
      joinDate: json["joinDate"] is String
          ? DateTime.parse(json["joinDate"])
          : DateTime.fromMillisecondsSinceEpoch(json["joinDate"]),
      birthDate: DateTime.parse(json["birthDate"]),
      email: json["emailAddress"],
      memberId: json["member_id"],
      phoneNumber: json["phoneNumber"],
      profilePicture: _getSubString(json["profile_picture"] ?? ""),
      zip: json["zip"],
      creditScoreEnabled: json["creditScoreEnabled"] ?? false,
    );
  }

  factory ProfileModel.empty() => ProfileModel(
        firstName: '',
        lastName: '',
        joinDate: DateTime.now(),
        birthDate: DateTime.now(),
        email: '',
        zip: '',
        phoneNumber: '',
        creditScoreEnabled: false,
        externalAccounts: [],
      );

  bool get isComplete {
    return profileStepsComplete >= totalProfileSteps;
  }

  int get profileStepsComplete {
    // Start with the three everyone must complete during account creation
    var complete = 4;
    if (profilePicture != null && profilePicture?.trim().isNotEmpty == true) {
      complete++;
    }

    if (creditScoreEnabled == true) {
      complete++;
    }

    if (externalAccounts.isNotEmpty) {
      complete++;
    }
    return complete;
  }

  int get totalProfileSteps {
    // Name, Birthday, Zipcode, mobile number
    // Profile picture, credit score, link account
    return 7;
  }
}

class ExternalAccount {
  String? name;
  String? mask;
  String? institution;

  ExternalAccount({this.name, this.mask, this.institution});

  factory ExternalAccount.fromJson(Map<String, dynamic> json) =>
      ExternalAccount(
        name: json["accountName"],
        mask: json["maskedNumber"],
        institution: json["institution"],
      );
}
