import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/personal_snapshot/total_debt_detail_model.dart';
import 'package:glorifi/src/services/total_debt_service.dart';
import '../../../controllers/plaid_controller.dart';

class TotalDebtController extends GetxController {
  String currentScreen = 'Total debt detail screen';
  PlaidController plaidController = Get.put(PlaidController());

  final formKey = GlobalKey<FormState>();
  Rx<TotalDebtDetailModel> totalDebtDetail = TotalDebtDetailModel().obs;
  var monthlyController = TextEditingController();
  final edit = false.obs;
  final disabledMonthly = false.obs;
  Rx<String> statusApi = ''.obs;

  var carousalIndex = 0.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  final RxBool loading = false.obs;

  void loadData({bool showLoading = true}) async {
    try {
      if (showLoading) {
        loading.value = true;
      }
      TotalDebtDetailModel response =
          await TotalDebtService().getTotalDebt() as TotalDebtDetailModel;
      totalDebtDetail.value = response;
      monthlyController.text =
          totalDebtDetail.value.monthlyIncome.toInt().toString();

      statusApi('success');
    } catch (e) {
      statusApi('500');
      Log.error(e);
    } finally {
      loading.value = false;
    }
  }

  // openComparison() {
  //   Get.bottomSheet(
  //     CompareValueScreen(
  //       gloriFiCompareState: GloriFiCompareType.creditDebt,
  //       member: totalDebtDetail.value.creditDebt.toString(),
  //     ),
  //     barrierColor: GlorifiColors.barrierColor,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //   );
  // }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  void EditIncome() {
    edit.value = true;
  }

  void CancelIncome() {
    edit.value = false;
  }

  void SaveIncome() async {
    if (formKey.currentState!.validate()) {
      disabledMonthly.value = true;
      await TotalDebtService()
          .postMonthlyIncome(int.parse(monthlyController.text));
      totalDebtDetail.value.monthlyIncome =
          double.parse(monthlyController.text);
      edit.value = false;
      disabledMonthly.value = false;

      ///refresh debt/income ratio
      loadData(showLoading: false);
    }
  }

  plaidLinkOpen() => plaidController.openPlaid();
}
