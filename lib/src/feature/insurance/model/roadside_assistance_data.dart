class RoadsideAssistanceData {
  RoadsideAssistanceData({
    required this.image,
    required this.title,
    required this.content,
  });
  late final String image;
  late final String title;
  late final String content;

  RoadsideAssistanceData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['title'] = title;
    _data['content'] = content;
    return _data;
  }
}
