import 'package:glorifi/src/model/personal_snapshot/dropdown_account.dart';

class TotalDebtDetailModel {
  TotalDebtDetailModel({
    this.totalDebt = 0,
    this.cardId = 0,
    this.description = "",
    this.title = "",
    this.creditDebt = 0,
    this.installmentDebt = 0,
    this.debtToIncomeRatio = 0,
    this.monthlyDebt = 0,
    this.monthlyIncome = 0,
    this.asOfDate,
    this.monthlyDebtPayment = 0,
    this.dataSource = '',
    this.installmentDebtAccounts = const [],
    this.creditDebtAccounts = const [],
    this.totalAccounts = 0,
  });

  final int cardId;
  final String description;
  final String title;
  final double totalDebt;
  final double creditDebt;
  final double installmentDebt;
  final double monthlyDebt;
  double monthlyIncome;
  final int debtToIncomeRatio;
  final DateTime? asOfDate;
  final double monthlyDebtPayment;
  final List<SingleDebtAccount> installmentDebtAccounts;
  final List<SingleDebtAccount> creditDebtAccounts;
  final String dataSource;
  int totalAccounts = 0;

  factory TotalDebtDetailModel.fromJson(Map<String, dynamic> json) {
    final List<SingleDebtAccount> _installmentDebtAccounts = [];
    final List<SingleDebtAccount> _creditDebtAccounts = [];

    final String _title = json['title'] != null ? json['title'] : "";
    final String _description =
        json['description'] != null ? json['description'] : "";
    final int _cardId = json['card_id'] != null ? json['card_id'] : 0;
    final double _totalDebt =
        json['total_debt'] != null ? json['total_debt'].toDouble() : 0;
    final double _creditDebt =
        json['credit_debt'] != null ? json['credit_debt'].toDouble() : 0;
    final double _installmentDebt = json['installment_debt'] != null
        ? json['installment_debt'].toDouble()
        : 0;
    final DateTime _asOfDate = DateTime.parse(json['as_of_date']);
    final double _monthlyDebtPayment = json['monthly_debt_payment'] != null
        ? json['monthly_debt_payment'].toDouble()
        : 0;
    final double _monthlyDebt = json['monthly_debt'] ?? 0.0;
    final double _monthlyIncome = json['monthly_income'] ?? 0.0;
    final int _debtToIncomeRatio = json['debt_to_income_ratio'] ?? 0;
    final String _dataSource = json['data_source'] ?? '';

    if (json['installment_debt_accounts'] != null) {
      List<dynamic> installmentList = json['installment_debt_accounts'];
      _installmentDebtAccounts.addAll(
          installmentList.map((e) => SingleDebtAccount.fromJson(e)).toList());
    }

    if (json['credit_debt_accounts'] != null) {
      List<dynamic> creditList = json['credit_debt_accounts'];
      _creditDebtAccounts.addAll(
          creditList.map((e) => SingleDebtAccount.fromJson(e)).toList());
    }

    return TotalDebtDetailModel(
      totalDebt: _totalDebt,
      creditDebt: _creditDebt,
      installmentDebt: _installmentDebt,
      asOfDate: _asOfDate,
      monthlyDebtPayment: _monthlyDebtPayment,
      debtToIncomeRatio: _debtToIncomeRatio,
      monthlyDebt: _monthlyDebt,
      monthlyIncome: _monthlyIncome,
      title: _title,
      installmentDebtAccounts: _installmentDebtAccounts,
      creditDebtAccounts: _creditDebtAccounts,
      cardId: _cardId,
      description: _description,
      dataSource: _dataSource,
      totalAccounts:
          _installmentDebtAccounts.length + _creditDebtAccounts.length,
    );
  }
}

class SingleDebtAccount implements DropDownAccount {
  SingleDebtAccount({
    required this.label,
    required this.name,
    required this.balance,
    required this.accountId,
  });

  final String label;
  final String name;
  final double balance;
  final String accountId;

  factory SingleDebtAccount.fromJson(Map<String, dynamic> json) {
    return SingleDebtAccount(
      label: json['official_name'] ?? '',
      name: json['name'] ?? '',
      balance: json['amount'],
      accountId: json['account_id'] ?? '',
    );
  }

  String get getLabel {
    return name;
  }
}
