import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/feature/insurance/model/base_response.dart';
import 'package:glorifi/src/feature/insurance/model/policies.dart';
import 'package:glorifi/src/feature/insurance/model/quote_response.dart';
import 'package:glorifi/src/feature/insurance/model/quotes.dart';
import 'package:glorifi/src/feature/insurance/model/roadside_assistance_data.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/insurance_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';

import '../../../utils/support/support_navigation_helper.dart';

class InsuranceController extends BaseController {
  RxList<Policies> activeInsuranceData = RxList<Policies>();
  RxList<Quotes> pendingInsuranceData = RxList<Quotes>();
  final isActiveExpanded = true.obs;
  final isPendingExpanded = false.obs;
  RxList<RoadsideAssistanceData> roadsideAssistanceData = RxList();

  @override
  void onInit() async {
    super.onInit();
    pullRefresh();
  }

  Future<void> pullRefresh() async {
    if (FeatureFlagManager.insuranceEnabled == false) {
      return;
    }
    await getQuotes();
    await getPolicies();
    roadsideAssistanceData.clear();
    await getAssistanceData();
  }

  Future<void> getQuotes() async {
    try {
      QuoteResponse response =
          await InsuranceService().getQuotes() as QuoteResponse;
      pendingInsuranceData.clear();
      pendingInsuranceData.addAll(response.data.quotes);
    } catch (e) {
      Log.error(e);
    }
  }

  Future<void> getPolicies() async {
    try {
      BaseResponse response =
          await InsuranceService().getPolicies() as BaseResponse;
      activeInsuranceData.clear();
      activeInsuranceData.addAll(response.data.assets);
    } catch (e) {
      Log.error(e);
    }
  }

  Future<void> addPolicy() async {
    Get.toNamed(Routes.insuranceCategoryList);
  }

  Future<void> navigateToFAQ() async {
    String category = 'Insurance';
    SupportNavigationHelper.navigateToList(category);
  }

  Future<void> navigateToRoadSideAssistance() async {
    Get.toNamed(Routes.roadsideAssistanceScreen);
  }

  Future<void> gotoPolicyDetails(
      {required String policyType,
      required String id,
      required String name}) async {
    var data = {"policyType": policyType, "policyId": id, "policyName": name};
    Get.toNamed(Routes.policyDetailsScreen, arguments: data);
  }

  Future<void> callForAssistance() async {
    //todo add call for assistance feature
  }

  Future<void> getAssistanceData() async {
    roadsideAssistanceData.value = [
      RoadsideAssistanceData(
          image: "assets/images/crane.svg",
          title: "Tow",
          content:
              "If you have mechanical trouble, set up a tow to a nearby repair shop"),
      RoadsideAssistanceData(
          image: "assets/images/tire.svg",
          title: "Flat tire",
          content:
              "If you have a spare tire, we can replace the flat or give you a tow"),
      RoadsideAssistanceData(
          image: "assets/images/fuel.svg",
          title: "Fuel delivery",
          content:
              "If you run out of fuel, we can deliver it to you. Fuel fees apply"),
      RoadsideAssistanceData(
          image: "assets/images/battery.svg",
          title: "Jump-start your battery.",
          content:
              "If your vehicle won't start we can give your battery a jump-start"),
      RoadsideAssistanceData(
          image: "assets/images/lock.svg",
          title: "We can unlock it",
          content:
              "If you're locked out of your vehicle, our technician can get it unlocked"),
      RoadsideAssistanceData(
          image: "assets/images/car.svg",
          title: "Stuck vehicle",
          content: "We can arrange to pull your vehicle out of mud or snow"),
    ];
  }
}
