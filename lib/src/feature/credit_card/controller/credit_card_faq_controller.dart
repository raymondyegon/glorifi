import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card/controller/credit_card_controller.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_faq_response.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/credit_card_faq_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CreditCardFAQController extends BaseController {
  RxList<Questions> creditCardFAQs = RxList<Questions>();
  final indexExpanded = (-1).obs;
  late CARD_TYPE card_type;

  final details =
      FAQData(cardType: "", description: "", questions: [], title: "").obs;

  @override
  void onInit() async {
    super.onInit();
    card_type = Get.arguments["card_type"] as CARD_TYPE;
    getCreditCardFAQ();
  }

  Future<void> getCreditCardFAQ() async {
    CreditCardFAQResponse response = await CreditCardFAQService()
        .getCreditCardFAQ() as CreditCardFAQResponse;
    creditCardFAQs.addAll(response.data.questions);
    details.value = response.data;
  }

  String getCardAsset() {
    if (card_type == CARD_TYPE.BRASS_CARD) {
      return GlorifiAssets.brassCard;
    } else {
      return GlorifiAssets.rewardsCard;
    }
  }

  String getBannerAsset() {
    if (card_type == CARD_TYPE.BRASS_CARD) {
      return GlorifiAssets.creditCardBanner;
    } else {
      return GlorifiAssets.rewardsCardBanner;
    }
  }

  Widget cardWidget() {
    if (card_type == CARD_TYPE.BRASS_CARD) {
      return Image.asset(
        GlorifiAssets.brassCard,
        fit: BoxFit.fill,
        height: 250.h,
        width: 400.w,
      );
    } else {
      return Image.asset(
        GlorifiAssets.rewardsCard,
        fit: BoxFit.fill,
        height: 210.h,
        width: 360.w,
      );
    }
  }

  void switchVisibility(int index) {
    if (indexExpanded.value != index) {
      indexExpanded.value = index;
    } else {
      indexExpanded.value = -1;
    }
  }

  Future<void> navigateToBlend() async {
    Get.toNamed(Routes.connectBlendSso);
  }
}
