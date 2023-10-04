import 'package:glorifi/src/feature/insurance/model/policies.dart';

class MyPolicyHeaderResponse {
  MyPolicyHeaderResponse({
    required this.assets,
  });
  late final List<Policies> assets;

  MyPolicyHeaderResponse.fromJson(Map<String, dynamic> json) {
    assets =
        List.from(json['policies']).map((e) => Policies.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['policies'] = assets.map((e) => e.toJson()).toList();
    return _data;
  }
}
