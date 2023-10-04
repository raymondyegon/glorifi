class InsuranceCategoryModel {
  InsuranceCategoryModel({
    required this.data,
  });
  late final List<InsuranceCategoryData> data;

  InsuranceCategoryModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => InsuranceCategoryData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class InsuranceCategoryData {
  InsuranceCategoryData({
    required this.name,
    required this.items,
  });
  late final String name;
  late final List<Items> items;

  InsuranceCategoryData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.categoryName,
    required this.icon,
  });
  late final int id;
  late final String categoryName;
  late final String icon;
  late final String? vendorUrl;
  late final String vendor;
  late final String? bindableUrl;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    icon = json['icon'];
    vendorUrl = json['vendorUrl'];
    vendor = json['vendor'];
    bindableUrl = json['bindableUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['categoryName'] = categoryName;
    _data['icon'] = icon;
    _data['vendorUrl'] = vendorUrl;
    _data['vendor'] = vendor;
    _data['bindableUrl'] = bindableUrl;
    return _data;
  }
}
