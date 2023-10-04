class HorizontalSeries {
  String? label;
  double? value;
  String? mode;
  String? category;

  //make named Constructior,
  HorizontalSeries(
    this.label,
    this.value,
    this.mode,
    this.category,
  );
  HorizontalSeries.fromJsonMap(Map<String, dynamic> map)
      : label = map["label"],
        value = double.parse(map["value"].toString()),
        mode = map["mode"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = label;
    data['value'] = value;
    data['mode'] = mode;
    return data;
  }

  //make CopyWith Methods
  HorizontalSeries copyWith({
    String? label,
    double? value,
    String? mode,
    String? category,
  }) {
    return HorizontalSeries(
      label ?? this.label,
      value ?? this.value,
      mode ?? this.mode,
      category ?? this.category,
    );
  }
}
