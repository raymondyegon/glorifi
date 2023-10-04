class LinkedInstitutionsModel {
  late List<LinkedInstitutionModel> institutions;

  LinkedInstitutionsModel({this.institutions = const []});

  LinkedInstitutionsModel.fromJson(Map<String, dynamic> json) {
    institutions = <LinkedInstitutionModel>[];
    if (json['institutions'] != null) {
      if (json['institutions'].isNotEmpty) {
        json['institutions'].forEach((v) {
          institutions.add(LinkedInstitutionModel.fromJson(v));
        });
      }
    }
  }
}

class LinkedInstitutionModel {
  late String institutionName;
  String? institutionLogo;
  late String id;

  late List<LinkedAccountModel> accounts;

  LinkedInstitutionModel(
      {required this.institutionName,
      this.institutionLogo,
      required this.id,
      this.accounts = const []});

  LinkedInstitutionModel.fromJson(Map<String, dynamic> json) {
    id = json['item_id'];
    institutionName = json['institution_name'] ?? '';
    institutionLogo = json['institution_logo'];
    if (json['accounts'] != null) {
      accounts = <LinkedAccountModel>[];
      json['accounts'].forEach((v) {
        accounts.add(LinkedAccountModel.fromJson(v));
      });
    }
  }
}

class LinkedAccountModel {
  String? name;
  String? officialName;
  String? mask;
  String? img;
  double? value;
  late String accountId;

  LinkedAccountModel(
      {this.name, this.officialName, this.mask, required this.accountId});

  LinkedAccountModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    img = json['img'];
    name = json['name'];
    officialName = json['official_name'];
    mask = json['mask'];
    accountId = json['account_id'];
  }
}
