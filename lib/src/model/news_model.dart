class NewsModel {
  String id;
  String imageUrl;
  String source;
  String headline;
  String url;
  DateTime updatedAt;

  NewsModel({
    required this.id,
    required this.imageUrl,
    required this.source,
    required this.headline,
    required this.url,
    required this.updatedAt,
  });
}
