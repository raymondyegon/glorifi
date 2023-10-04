class StateData {
  StateData();

  late final String state;
  late final String sign;

  StateData.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['state'] = state;
    _data['sign'] = sign;
    return _data;
  }
}
