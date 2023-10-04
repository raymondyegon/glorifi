import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/feature/mortgage/model/mortgage_data.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/mortgage_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:intl/intl.dart';

import '../../../utils/support/support_navigation_helper.dart';

class MortgageController extends BaseController {
  RxList<MortgageData> activeMortgageData = RxList<MortgageData>();
  RxList<MortgageData> pendingMortgageData = RxList<MortgageData>();
  final isLoading = true.obs;
  var numPages = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  var currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    getMortgages();
  }

  Future<void> pullRefresh() async {
    await getMortgages();
  }

  Future<void> getMortgages() async {
    if (FeatureFlagManager.mortgageEnabled == false) {
      return;
    }
    try {
      isLoading(true);
      MortgageDataResponse response =
          await MortgageService().getMortgageData() as MortgageDataResponse;
      activeMortgageData.clear();
      activeMortgageData.addAll(response.data.reversed.toList());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addMortgage() async {
    Get.toNamed(Routes.mortgagePreApply);
  }

  Future<void> navigateMortgagePreApply() async {
    Get.toNamed(Routes.mortgagePreApply)?.then(
      (value) {
        if (value != null) {
          getMortgages();
        }
      },
    );
  }

  Future<void> navigateMortgageDetail() async {
    Get.toNamed(Routes.mortgageDetail);
  }

  Future<void> navigateToBlend() async {
    Get.toNamed(Routes.connectBlendSso, parameters: {'title': 'Mortgage'})
        ?.then(
      (value) => getMortgages(),
    );
  }

  Future<void> navigateToFAQ() async {
    String category = 'Mortgage';
    SupportNavigationHelper.navigateToList(category);
  }

  String dateFormatter(String date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(DateTime.parse(date));
    return formattedDate;
  }
}
