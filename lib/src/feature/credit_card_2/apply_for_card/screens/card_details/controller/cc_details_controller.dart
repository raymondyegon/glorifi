import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/basic_card_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/brass_card_details_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class CCDetailsController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    prepareBrassCardDetailsModelData();
    prepareBasicCardDetailsModelData();
  }

  final _brassCardDetailsModelController = BrassCardDetailsModel().obs;
  final _basicCardDetailsModelController = BasicCardDetailsModel().obs;

  BrassCardDetailsModel get brassCardDetailsModel =>
      _brassCardDetailsModelController.value;

  BasicCardDetailsModel get basicCardDetailsModel =>
      _basicCardDetailsModelController.value;

  void prepareBrassCardDetailsModelData() {
    BrassCardRewardDataModel brassCardRewardDataModel =
        BrassCardRewardDataModel(
      reward: "2%",
      apr: '15.99%-20.99%',
      annualFee: 525,
    );
    BrassCardRewardModel brassCardRewardModel = BrassCardRewardModel(
      title: "2% rewards on every purchase",
      description:
          "For every dollar you spend, you earn 2 reward points. These points can be redeemed for a variety of perks, ranging from cash back to donating to the Tunnel to Towers Foundation. ",
      data: brassCardRewardDataModel,
    );
    BrassCardElitePartnerPerksModel brassCardElitePartnerPerks =
        BrassCardElitePartnerPerksModel(
      title: 'World Elite Partner Perks',
      perks: [
        r'Get a $5 Credit with Lyft',
        'Enjoy Great Savings From Doordash',
        'Save On HelloFresh',
        'Get a ShopRunner Membership',
        'Score Rewards From Fandango'
      ],
    );
    BrassCardBenefitsModel brassCardBenefitsModel = BrassCardBenefitsModel(
      title: 'More Benefits',
      benefits: [
        'Mastercard Golf',
        'Priceless Cities Offers',
        'Airport Concierge',
        'Identity Theft Protection',
        'Zero Liability Protection',
        'Global Emerency Service'
      ],
    );
    BrassCardDetailsFooterModel brassCardFooter = BrassCardDetailsFooterModel(
        image: GlorifiAssets.gloriFiBrassCard,
        title: 'Made with real cartridge brass',
        description:
            'A world-class card that makes a statement with every purchase, the Cartridge Brass World Elite Mastercard® card weighs in at an impressive 20 grams. You’ll be proud to show your metal. ',
        disclosure:
            r'The standard variable APR for purchases is 14.74% – 24.74%. The standard variable APR for balance transfers is 14.74% – 24.74%. The standard variable APR for cash advances is 14.74% – 24.74%. Please note that these rates will vary with the Prime Rate. If you are charged interest, the charge will be no less than $1.00. Annual Fee – $525.00 for the Cartridge Brass (World Elite) Card, $0.00 for the Enhanced Card. Fee for balance transfers – either $5.00 or 3% of the amount of each transfer, whichever is greater. Fee for cash advances – either $10.00 or 5% of the amount of each cash advance, whichever is greater. Fee for foreign transactions – 3% of the amount of each transaction in U.S. dollars. Subject to credit approval. Additional limitations, terms, and conditions apply. You will receive additional information when you apply.');
    BrassCardDetailsModel brassCardDetailsModel = BrassCardDetailsModel(
        image: GlorifiAssets.gloriFiBrassCard,
        title: "DON'T CONCEAL YOUR ELITE STATUS",
        subTitle: "Cartridge brass World Elite Mastercard® card",
        description:
            "An exclusive, elite card that’s perfect for everyday carry, the GloriFi Cartridge Brass World Elite Mastercard® is the heaviest cartridge brass contactless card on the market – and it’s only available to GloriFi members.",
        rewards: brassCardRewardModel,
        brassCardServices: [
          'Concierge Services',
          'Cellular Wireless Protection',
          'Travel and Lifestyle Services'
        ],
        partners: [
          GlorifiAssets.ic_lyft,
          GlorifiAssets.ic_door_dash,
          GlorifiAssets.ic_hello_fresh,
          GlorifiAssets.ic_shop_runner,
          GlorifiAssets.ic_fandango,
        ],
        brassCardElitePartnerPerks: brassCardElitePartnerPerks,
        brassCardBenefitsModel: brassCardBenefitsModel,
        brassCardFooter: brassCardFooter);
    _brassCardDetailsModelController(brassCardDetailsModel);
  }

  void prepareBasicCardDetailsModelData() {
    BasicCardRewardDataModel rewardData = BasicCardRewardDataModel(
        reward: "1.5%", apr: '15.99%-20.99%', annualFee: 0);
    var basicCardRewardModel = BasicCardRewardModel(
        title: "1.5% rewards on every purchase",
        description:
            "Earn 1.5% rewards points or cash back every time you tap, insert, or swipe to pay. It’s a powerful way to show your respect for those who put their lives on the line. ",
        data: rewardData);
    BasicCardBenefitModel basicCardBenefitModel = BasicCardBenefitModel(
      title: 'More Benefits',
      benefits: [
        'Mastercard Golf',
        'Priceless Cities Offers',
        'Airport Concierge',
        'Identity Theft Protection',
        'Zero Liability Protection',
        'Global Emerency Service'
      ],
    );
    List<BasicCardDesignPreviewModel> basicCardDesignPreviewModels = [
      BasicCardDesignPreviewModel(
          image: GlorifiAssets.gloriFiCreditCardConstitution,
          description:
              'Show your respect for those who put their lives on the line'),
      BasicCardDesignPreviewModel(
          image: GlorifiAssets.gloriFiCreditCard1776,
          description: 'Show your love of country with the Consitution Card'),
      BasicCardDesignPreviewModel(
          image: GlorifiAssets.gloriFiCreditCardThinBlueLine,
          description:
              'Celebrate the foundation of our great nation with the GloriFi 1776'),
    ];
    BasicCardDesignModel basicCardDesignModel = BasicCardDesignModel(
        title: 'With meaningful card designs',
        previewModel: basicCardDesignPreviewModels);
    _basicCardDetailsModelController(
      BasicCardDetailsModel(
          image: GlorifiAssets.gloriFiCreditCardThinBlueLine,
          title: "ARM YOUR WALLET WITH MASTERCARD BENEFITS",
          subTitle: "GloriFi Mastercard®",
          description:
              "Get all the everyday benefits of Mastercard® without an annual fee. Enjoy Mastercard® Golf, airport concierge services, ID protection, fraud alerts, and more.",
          basicCardRewardModel: basicCardRewardModel,
          basicCardBenefitModel: basicCardBenefitModel,
          basicCardDesignModel: basicCardDesignModel,
          basicCardFooterModel:
              r'The standard variable APR for purchases is 14.74% – 24.74%. The standard variable APR for balance transfers is 14.74% – 24.74%. The standard variable APR for cash advances is 14.74% – 24.74%. Please note that these rates will vary with the Prime Rate. If you are charged interest, the charge will be no less than $1.00. Annual Fee – $525.00 for the Cartridge Brass (World Elite) Card, $0.00 for the Enhanced Card. Fee for balance transfers – either $5.00 or 3% of the amount of each transfer, whichever is greater. Fee for cash advances – either $10.00 or 5% of the amount of each cash advance, whichever is greater. Fee for foreign transactions – 3% of the amount of each transaction in U.S. dollars. Subject to credit approval. Additional limitations, terms, and conditions apply. You will receive additional information when you apply.'),
    );
  }
}
