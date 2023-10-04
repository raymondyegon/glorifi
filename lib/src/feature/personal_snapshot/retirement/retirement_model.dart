import 'package:glorifi/src/model/personal_snapshot/dropdown_account.dart';

class RetirementModel {
  RetirementModel({
    required this.cardId,
    required this.title,
    required this.description,
    required this.current,
    required this.employeeSponsored,
    required this.indivRetirementAccounts,
    required this.accounts,
  });
  late final int cardId;
  late final String title;
  late final String description;
  late final double current;
  late final double employeeSponsored;
  late final double indivRetirementAccounts;
  late final Accounts accounts;

  RetirementModel.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
    title = json['title'];
    description = json['description'];
    current = json['current'];
    employeeSponsored = json['employee_sponsored'];
    indivRetirementAccounts = json['indiv_retirement_accounts'];
    accounts = Accounts.fromJson(json['accounts']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['card_id'] = cardId;
    _data['title'] = title;
    _data['description'] = description;
    _data['current'] = current;
    _data['employee_sponsored'] = employeeSponsored;
    _data['indiv_retirement_accounts'] = indivRetirementAccounts;
    _data['accounts'] = accounts.toJson();
    return _data;
  }
}

class Accounts {
  Accounts({
    required this.employerSponsoredAccounts,
    required this.individualAccounts,
  });
  late final List<RetirementAccount> employerSponsoredAccounts;
  late final List<RetirementAccount> individualAccounts;

  Accounts.fromJson(Map<String, dynamic> json) {
    employerSponsoredAccounts = List.from(json['employer_sponsored_accounts'])
        .map((e) => RetirementAccount.fromJson(e))
        .toList();
    individualAccounts = List.from(json['individual_accounts'])
        .map((e) => RetirementAccount.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer_sponsored_accounts'] =
        employerSponsoredAccounts.map((e) => e.toJson()).toList();
    _data['individual_accounts'] =
        individualAccounts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class RetirementAccount implements DropDownAccount {
  RetirementAccount({
    required this.accountId,
    required this.balance,
    required this.name,
    this.officialName,
    required this.mask,
    required this.institution,
    required this.institutionLogo,
  });
  late final String accountId;
  late final double balance;
  late final String name;
  late final Null officialName;
  late final String mask;
  late final String institution;
  late final String institutionLogo;

  RetirementAccount.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    balance = json['balance'];
    name = json['name'];
    officialName = null;
    mask = json['mask'];
    institution = json['institution'];
    institutionLogo = json['institution_logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['account_id'] = accountId;
    _data['balance'] = balance;
    _data['name'] = name;
    _data['official_name'] = officialName;
    _data['mask'] = mask;
    _data['institution'] = institution;
    _data['institution_logo'] = institutionLogo;
    return _data;
  }

  String get getLabel {
    return institution;
  }
}
