import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../banking/controller/my_bank_controller.dart';

enum CardType {
  video,
  info,
  bankAccount,
  creditScore,
  standard,
  // product,
}

/*

The order of this list is the order we show the cards

 */
enum HighlightType {
  applicationStatus,
  applicationStatus1,
  applicationStatus2,
  bankAccount,
  creditScore,
  insights,
  referral,
  content,
  secondaryTask,
  products,
}

/*

HIGHLIGHT CARD MODELS

*/

class HighlightModel {
  CardType cardType;
  String title;
  String? imageUri;
  String? route;
  bool isPlaid;

  HighlightModel({
    required this.title,
    required this.cardType,
    this.imageUri,
    this.route,
    this.isPlaid = false,
  });
}

// Will either have an imageUri or backgroundColor
class StandardHighlightModel extends HighlightModel {
  String callToAction;
  String secondary;

  StandardHighlightModel({
    cardType,
    title,
    imageUri,
    route,
    isPlaid = false,
    required this.callToAction,
    required this.secondary,
  }) : super(
            cardType: cardType,
            title: title,
            imageUri: imageUri,
            route: route,
            isPlaid: isPlaid);
}

class VideoHighlightModel extends HighlightModel {
  String videoUri;

  VideoHighlightModel({
    title,
    imageUri,
    route,
    required this.videoUri,
  }) : super(
            cardType: CardType.video,
            title: title,
            route: route == Routes.myBanking
                ? Get.toNamed(Routes.openBankAccount)
                : route,
            imageUri: imageUri);
}

class BankAccountHighlightModel extends HighlightModel {
  String savings;
  String checking;

  factory BankAccountHighlightModel.fromJson(Map<String, dynamic> json) =>
      BankAccountHighlightModel(
        savings: json["total_savings"],
        checking: json["total_checking"],
      );

  BankAccountHighlightModel({
    required this.savings,
    required this.checking,
  }) : super(
          cardType: CardType.bankAccount,
          title: "",
        );
}

class CreditScoreHighlightModel extends HighlightModel {
  int score;
  int points;
  DateTime nextUpdated;
  DateTime lastUpdated;

  factory CreditScoreHighlightModel.fromJson(Map<String, dynamic> json) =>
      CreditScoreHighlightModel(
        score: json["score"],
        points: json["delta"],
        nextUpdated: json["next_update"],
        lastUpdated: json["last_updated"],
      );

  CreditScoreHighlightModel({
    required this.score,
    required this.points,
    required this.nextUpdated,
    required this.lastUpdated,
  }) : super(
          cardType: CardType.creditScore,
          title: "Credit Score",
        );
}

/*
ENDPOINT MODELS
*/

class ApplicationStatusModel {
  bool mortgageUpdated;
  bool insuranceUpdated;
  bool bankingUpdated;

  factory ApplicationStatusModel.fromJson(Map<String, dynamic> json) =>
      ApplicationStatusModel(
        mortgageUpdated: json["mortgage"] ?? false,
        insuranceUpdated: json["insurance"] ?? false,
        bankingUpdated: json["banking"] ?? false,
      );

  ApplicationStatusModel({
    required this.mortgageUpdated,
    required this.insuranceUpdated,
    required this.bankingUpdated,
  }) : super();
}
