import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

enum FlaggableFeature { banking, mortgage, creditCard, insurance, brokerage }

class FeatureFlagController extends GetxController {
  final showProductsTab = true.obs;

  final available = <FlaggableFeature>[].obs;
  final comingSoon = <FlaggableFeature>[].obs;

  final _apiHelper = DataHelperImpl.instance.apiHelper;

  @override
  void onInit() {
    _fetchFeatureFlags();
    super.onInit();
  }

  void _fetchFeatureFlags() async {
    try {
      final response = await _apiHelper.getFeatureFlags();
      showProductsTab.value = response['data']['enableBanking'] == false;
      // Banking is always available

      available.add(FlaggableFeature.banking);

      response['data']['enableCreditCard'] == true
          ? available.add(FlaggableFeature.creditCard)
          : comingSoon.add(FlaggableFeature.creditCard);

      // response['data']['enableBrokerage'] == true
      //     ? available.add(FlaggableFeature.brokerage)
      //     : comingSoon.add(FlaggableFeature.brokerage);

      response['data']['enableMortgage'] == true
          ? available.add(FlaggableFeature.mortgage)
          : comingSoon.add(FlaggableFeature.mortgage);

      response['data']['enableInsurance'] == true
          ? available.add(FlaggableFeature.insurance)
          : comingSoon.add(FlaggableFeature.insurance);
    } catch (e) {
      // If this request fails, better to default to showing Products?
      showProductsTab.value = true;
      // TODO: Remove this. Debugging only
      comingSoon.value = [
        FlaggableFeature.creditCard,
       
        FlaggableFeature.insurance,
      ];
      available.value = [
        FlaggableFeature.banking,
        FlaggableFeature.mortgage,
      ];
      Log.error(e);
    }
  }
}
