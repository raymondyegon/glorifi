class BannerDataModel {
  BannerDataModel({
    required this.data,
  });

  late final List<Data> data;

  BannerDataModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.title,
    required this.subtitle,
  });

  late final String title;
  late final String subtitle;
  late final String imageUrl;

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}
