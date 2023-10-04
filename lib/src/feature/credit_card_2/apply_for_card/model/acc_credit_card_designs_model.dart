import 'package:glorifi/src/utils/glorifi_assets.dart';

class ACCCreditCardDesignModel {
  ACCCreditCardDesignModel({
    required this.path,
    required this.cardName,
    required this.cardDescription,
  });

  final String path;
  final String cardName;
  final String cardDescription;
}

List<ACCCreditCardDesignModel> get creditCards => _creditCardDesignList;

List<ACCCreditCardDesignModel> _creditCardDesignList = [
  ACCCreditCardDesignModel(
    path: GlorifiAssets.gloriFiCreditCardConstitution,
    cardName: "Constitution",
    cardDescription:
        "A strong reminder of the freedom and independence we share as Americans, we the people send a message with every purchase when using this card.",
  ),
  ACCCreditCardDesignModel(
    path: GlorifiAssets.gloriFiCreditCard1776,
    cardName: "1776",
    cardDescription:
        "Celebrate America's founding principles of life, liberty and the pursuit of happiness with this card.",
  ),
  ACCCreditCardDesignModel(
    path: GlorifiAssets.gloriFiCreditCardThinBlueLine,
    cardName: "Thin Blue Line",
    cardDescription:
        "Each day, brave men and women in blue across the country put on bulletproof vests and risk their lives to defend our families and protect our communities. Show your support for these heroes with this card.",
  ),
];

List<String> creditCardsPreview = [
  GlorifiAssets.gloriFiCreditCardConstitution,
  GlorifiAssets.gloriFiCreditCard1776,
  GlorifiAssets.gloriFiCreditCardThinBlueLine,
];
