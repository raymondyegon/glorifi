import 'dart:collection';

import 'package:glorifi/src/model/personal_snapshot/single_account_item_model.dart';

class NetWorthDetailModel {
  NetWorthDetailModel({
    required this.totalAmount,
    required this.assets,
    required this.liabilities,
  });

  final double totalAmount;
  final NetWorthAssets assets;
  final NetWorthLiabilities liabilities;

  factory NetWorthDetailModel.fromJson(Map<dynamic, dynamic> json) {
    final _totalAmount = json['total_net_worth'];
    final _assets = NetWorthAssets.fromJson(json['assets']);
    final _liabilities = NetWorthLiabilities.fromJson(json['liabilities']);

    return NetWorthDetailModel(
      totalAmount: _totalAmount,
      assets: _assets,
      liabilities: _liabilities,
    );
  }
}

class NetWorthLiabilities {
  NetWorthLiabilities({
    this.creditAccounts = const [],
    this.loanAccounts = const [],
  });

  final List<SingleAccountItemModel> creditAccounts;
  final List<SingleAccountItemModel> loanAccounts;

  factory NetWorthLiabilities.fromJson(Map<dynamic, dynamic> json) {
    final List<SingleAccountItemModel> _creditAccounts = [];
    final List<SingleAccountItemModel> _loanAccounts = [];

    if (json['credit'] != null) {
      json['credit'].forEach((item) {
        _creditAccounts.add(SingleAccountItemModel.fromJson(item));
      });
    }
    if (json['loan'] != null) {
      json['loan'].forEach((item) {
        _loanAccounts.add(SingleAccountItemModel.fromJson(item));
      });
    }

    return NetWorthLiabilities(
      creditAccounts: _creditAccounts,
      loanAccounts: _loanAccounts,
    );
  }
}

class NetWorthAssets {
  NetWorthAssets({
    required this.depositoryAccounts,
    required this.investmentAccounts,
    required this.homeAccounts,
  });

  final List<SingleAccountItemModel> depositoryAccounts;
  final List<SingleAccountItemModel> investmentAccounts;
  final List<SingleAccountItemModel> homeAccounts;

  factory NetWorthAssets.fromJson(Map<dynamic, dynamic> json) {
    final List<SingleAccountItemModel> _depositoryAccounts = [];
    final List<SingleAccountItemModel> _investmentAccounts = [];
    final List<SingleAccountItemModel> _homeAccounts = [];

    if (json['depository'] != null) {
      json['depository'].forEach((item) {
        _depositoryAccounts.add(SingleAccountItemModel.fromJson(item));
      });
    }

    if (json['investment'] != null) {
      json['investment'].forEach((item) {
        _investmentAccounts.add(SingleAccountItemModel.fromJson(item));
      });
    }
    if (json['home'] != null) {
      json['home'].forEach((item) {
        _homeAccounts.add(SingleAccountItemModel.fromJson(item));
      });
    }

    return NetWorthAssets(
      homeAccounts: _homeAccounts,
      investmentAccounts: _investmentAccounts,
      depositoryAccounts: _depositoryAccounts,
    );
  }
}
