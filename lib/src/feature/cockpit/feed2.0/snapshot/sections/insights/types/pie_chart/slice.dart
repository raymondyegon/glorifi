class Slice {
  final int month;
  final bool highlight;
  final String category;
  final double value;
  final int index;

  Slice.fromJsonMap(Map<String, dynamic> map)
      : month = map["month"],
        highlight = map["highlight"],
        category = map["category"],
        value = map["value"],
        index = map["index"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['month'] = month;
    data['highlight'] = highlight;
    data['category'] = category;
    data['value'] = value;
    data['index'] = index;
    return data;
  }
}
