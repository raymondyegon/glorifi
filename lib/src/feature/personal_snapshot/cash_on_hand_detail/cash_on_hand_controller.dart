import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/cash_on_hand_model.dart';
import 'package:glorifi/src/widgets/charts/horizontal_bar_chart.dart';

import '../../../core/data_helper.dart';
import '../../../core/exceptions/custom_exception.dart';
import '../../../utils/glorifi_colors.dart';
import '../compare/compare_value.dart';

class CashOnHandControllerV1 extends GetxController {
  PlaidController plaidController = Get.put(PlaidController());

  final _dataHelper = DataHelperImpl.instance;
  Rx<CashOnHandModel> cashOnHandModel = CashOnHandModel().obs;
  var error = "".obs;
  var loading = false.obs;
  String currentScreen = 'Total debt detail screen';
  Rx<String> statusApi = ''.obs;

  RxList<HorizontalBarChartTypeInfo> chartData = RxList.empty();

  @override
  void onInit() {
    getCashOnHandDetail();
    super.onInit();
  }

  Future<void> getCashOnHandDetail() async {
    loading.value = true;
    try {
      final response = await _dataHelper.apiHelper.getCashOnHandDetails();
      response.fold((error) {
        statusApi('500');
      }, (success) => setCashOnHandModel(success));
    } catch (e) {
      statusApi('500');
      Log.error(e);
    } finally {
      loading.value = false;
    }
  }

  setCashOnHandModel(CashOnHandModel model) {
    cashOnHandModel.value = model;
    chartData.clear();
    chartData.addAll([
      HorizontalBarChartTypeInfo(
        "Checking",
        cashOnHandModel.value.data?.checkingAmount ?? 0,
      ),
      HorizontalBarChartTypeInfo(
        "Savings",
        cashOnHandModel.value.data?.savingsAmount ?? 0,
      ),
      HorizontalBarChartTypeInfo(
        "Other",
        cashOnHandModel.value.data?.otherAmount ?? 0,
      ),
    ]);
    statusApi('success');
  }

  setError(CustomException error) {
    statusApi('500');
    this.error.value = error.errorMessage;
  }

  // openComparison() {
  //   Get.bottomSheet(
  //     CompareValueScreen(
  //       gloriFiCompareState: GloriFiCompareType.cashOnHand,
  //       member: cashOnHandModel.value.data!.totalAmount.toString(),
  //     ),
  //     barrierColor: GlorifiColors.barrierColor,
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //   );
  // }

  plaidLinkOpen() => plaidController.openPlaid();
}
