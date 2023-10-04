class FAQCategories {
  String? key;
  String? title;
  String? path;
  String? parent;
  String? type;
  List<Children>? children;

  FAQCategories(
      {this.key, this.title, this.path, this.parent, this.type, this.children});

  FAQCategories.fromJson(Map<String, dynamic> json) {
    // key = json['key'] ?? '';
    key = json['_id'] ?? '';
    title = json['title'];
    // path = json['path'];
    // parent = json['parent'];
    // type = json['type'];
    // if (json['children'] != null) {
    //   children = <Children>[];
    //   json['children'].forEach((v) {
    //     children!.add(Children.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['key'] = key;
    data['_id'] = key;
    data['title'] = title;
    // data['path'] = path;
    // data['parent'] = parent;
    // data['type'] = type;
    // if (children != null) {
    //   data['children'] = children!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class FAQCategoriesResponseModel {
  List<FAQCategories>? data;

  FAQCategoriesResponseModel({this.data});

  FAQCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    if (json['data']!['libraries'] != null) {
      data = <FAQCategories>[];
      // json['data'].forEach((v) {
      json['data']!['libraries'].forEach((v) {
        data!.add(FAQCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? key;
  String? title;
  String? path;
  String? parent;
  String? type;

  Children({this.key, this.title, this.path, this.parent, this.type});

  Children.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = key;
    data['title'] = title;
    return data;
  }
}
