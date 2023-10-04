import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';

class BankingBannerModel {
  late final List<BankingBannerDataModel> data;

  BankingBannerModel({
    required this.data,
  });

  BankingBannerModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => BankingBannerDataModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BankingBannerDataModel {
  late final String title;
  late final String subtitle;
  late final AccountType type;
  BankingBannerDataModel({required this.title, required this.subtitle});
  BankingBannerDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['type'] = type;
    return _data;
  }
}
