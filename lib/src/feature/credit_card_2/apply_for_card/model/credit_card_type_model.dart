import 'package:glorifi/src/utils/glorifi_assets.dart';

class CreditCardTypeModel {
  final String? title;
  final String? description;
  final String? annualFee;
  final String? buttonText;
  final String? cardAsset;

  CreditCardTypeModel({
    this.title,
    this.description,
    this.annualFee,
    this.buttonText,
    this.cardAsset,
  });
}

extension CreditCardType on CreditCardTypeModel {
  static CreditCardTypeModel brassCard = CreditCardTypeModel(
    title: 'Cartridge brass World Elite Mastercard® card',
    description:
        r'For every dollar you spend, you earn 1.5 reward points. These points can be redeemed for a variety of perks, ranging from cash back to donating to Tunnels to Towers. Every 100 points is worth \$1.',
    buttonText: 'Carry the Brass',
    annualFee: '\$525 \nAnnual Fee',
    cardAsset: GlorifiAssets.gloriFiBrassCard,
  );
  static CreditCardTypeModel masterCard = CreditCardTypeModel(
    title: 'GloriFi Mastercard®',
    description:
        'An exclusive, elite card that’s perfect for everyday carry. This is the heaviest cartridge brass contactless card on the market.',
    buttonText: 'Get this card',
    annualFee: 'No',
    cardAsset: GlorifiAssets.gloriFiCreditCard1776,
  );
}
