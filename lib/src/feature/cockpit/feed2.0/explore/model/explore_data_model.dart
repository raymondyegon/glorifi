class ExploreDataModel {
  ExploreDataModel({
    required this.data,
  });

  late final List<ExploreData> data;

  ExploreDataModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => ExploreData.fromJson(e)).toList();
  }
}

class ExploreData {
  ExploreData({
    required this.category,
    this.desc,
    required this.contents,
  });

  late final String category;
  late final String? desc;
  late final List<Contents> contents;

  ExploreData.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    desc = json['desc'];
    contents =
        List.from(json['contents']).map((e) => Contents.fromJson(e)).toList();
  }
}

class Contents {
  Contents({
    required this.title,
    this.subtitle,
    required this.asset,
    required this.showSubtitle,
    required this.type,
    this.route,
  });

  late final String title;
  late final String? subtitle;
  late final String asset;
  late final bool? showSubtitle;
  late final String type;
  late final String? route;
  late final String? args;

  Contents.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    asset = json['asset'];
    showSubtitle = json['showSubtitle'];
    route = json['route'];
    args = json['args'];
  }
}
