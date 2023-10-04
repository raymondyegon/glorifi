import 'package:enum_to_string/enum_to_string.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:timeago/timeago.dart' as timeago;

enum StoryType {
  FeaturedVideo,
  SecondaryVideo,
  FeaturedArticle,
  SecondaryArticle,
  Quote,
  Fact,
  Invite,
  Product,
  GloriFiStory,
  LastStory,
  Ghost,
  ServerError,
}

// Do not modify. This is what we expect to get back from the server
enum StoryProductTypes {
  creditCard,
  heroBundle,
  protectBundle,
  homefrontBundle,
  insurance,
  banking,
}

enum StoryContentType { Video, Article }

class StoryModel {
  String? backgroundImage;
  String? route;

  StoryType type;

  StoryModel({
    this.backgroundImage,
    this.route,
    required this.type,
  });
}

class MultiVideoStoryModel extends StoryModel {
  List<VideoStoryModel> secondary;
  VideoStoryModel hero;

  MultiVideoStoryModel({route, required this.secondary, required this.hero})
      : super(type: StoryType.SecondaryVideo, route: route);

  factory MultiVideoStoryModel.fromJson(Map<String, dynamic> json) =>
      MultiVideoStoryModel(
        hero: VideoStoryModel.fromJson(json["hero"]),
        secondary:
            json["secondary"].map((data) => VideoStoryModel.fromJson(data)),
      );
}

class VideoStoryModel extends StoryModel {
  String imageUrl;
  String videoUrl;
  String headline;
  String source;
  int? duration;
  String contentId;

  VideoStoryModel(
      {type,
      backgroundImage,
      route,
      required this.contentId,
      required this.imageUrl,
      required this.videoUrl,
      required this.headline,
      required this.source,
      required this.duration})
      : super(
            type: StoryType.FeaturedVideo,
            backgroundImage: backgroundImage,
            route: route);

  factory VideoStoryModel.fromJson(Map<String, dynamic> json) =>
      VideoStoryModel(
        headline: json["headline"],
        imageUrl: json["imageUrl"],
        backgroundImage: json['imageUrl'],
        videoUrl: json["videoUrl"],
        source: json["source"] ?? "GloriFi",
        duration: json["duration"],
        contentId: json["content_id"],
      );
}

class MultiArticleStoryModel extends StoryModel {
  List<ArticleStoryModel> secondary;
  ArticleStoryModel hero;

  MultiArticleStoryModel({route, required this.secondary, required this.hero})
      : super(type: StoryType.SecondaryArticle, route: route);

  factory MultiArticleStoryModel.fromJson(Map<String, dynamic> json) =>
      MultiArticleStoryModel(
        hero: ArticleStoryModel.fromJson(json["hero"]),
        secondary:
            json["secondary"].map((data) => ArticleStoryModel.fromJson(data)),
      );
}

// TODO: add last updated
class ArticleStoryModel extends StoryModel {
  String imageUrl;
  String? content;
  String? url;
  String headline;
  String source;
  String? author;
  int? duration;
  String contentId;

  DateTime? publishDate;

  String get formattedPublishDate {
    if (publishDate == null) {
      return "";
    }
    return timeago.format(publishDate!, allowFromNow: false);
  }

  ArticleStoryModel({
    type,
    backgroundImage,
    route,
    required this.imageUrl,
    this.content,
    this.url,
    required this.headline,
    required this.source,
    required this.duration,
    this.author,
    required this.publishDate,
    required this.contentId,
  }) : super(
            type: StoryType.FeaturedArticle,
            backgroundImage: backgroundImage,
            route: route);

  factory ArticleStoryModel.fromJson(Map<String, dynamic> json) =>
      ArticleStoryModel(
        headline: json["headline"],
        imageUrl: json["imageUrl"],
        backgroundImage: json["imageUrl"],
        content: json["content"],
        url: json["url"],
        source: json["source"],
        duration: json["duration"],
        author: json["author"],
        publishDate: DateTime.tryParse(json["publishDate"]) ?? DateTime.now(),
        contentId: json["content_id"],
      );
}

class QuoteStoryModel extends StoryModel {
  String quote;
  String author;

  QuoteStoryModel({
    backgroundImage,
    required this.quote,
    required this.author,
  }) : super(
            type: StoryType.Quote,
            backgroundImage: backgroundImage,
            route: backgroundImage);

  factory QuoteStoryModel.fromJson(Map<String, dynamic> json) =>
      QuoteStoryModel(
        quote: json["quote"],
        author: json["author"],
      );
}

class FactStoryModel extends StoryModel {
  String fact;

  FactStoryModel({
    backgroundImage,
    required this.fact,
  }) : super(
            type: StoryType.Fact,
            backgroundImage: backgroundImage,
            route: backgroundImage);

  factory FactStoryModel.fromJson(Map<String, dynamic> json) =>
      FactStoryModel(fact: json["fact"], backgroundImage: json["imageUrl"]);
}

class LastStoryModel extends StoryModel {
  String message;

  LastStoryModel({
    required this.message,
  }) : super(
          type: StoryType.LastStory,
        );

  factory LastStoryModel.fromJson(Map<String, dynamic> json) => LastStoryModel(
        message: json["message"],
      );
}

class ProductStoryModel extends StoryModel {
  StoryProductTypes productType;

  ProductStoryModel({
    required this.productType,
  }) : super(
          type: StoryType.Product,
        );

  factory ProductStoryModel.fromJson(Map<String, dynamic> json) =>
      ProductStoryModel(
        productType: EnumToString.fromString(
            StoryProductTypes.values, json['productType'])!,
      );
}

class BundleModel {
  String title;
  List<String> options;
  String route;
  String image;
  BundleType bundleType;

  BundleModel({
    required this.title,
    required this.options,
    required this.route,
    required this.image,
    required this.bundleType,
  });
}
