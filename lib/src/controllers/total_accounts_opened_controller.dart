import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/model/total_accounts_opened_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class TotalAccountsOpenedController extends BaseController
    with GetSingleTickerProviderStateMixin {
  var _dataHelper = DataHelperImpl.instance;

  bool enableData = false;
  TotalAccountsOpenedModel data = TotalAccountsOpenedModel();
  String openAccount = '0';
  String closedAccount = '0';

  @override
  void onInit() async {
    final response =
        await _dataHelper.apiHelper.getTotalAccountsPersonalSnapshots();
    debugPrint('RRRRRR: $response');
    Future.delayed(Duration(seconds: 1), () => change(RxStatus.loading()));
    response.fold(
      (l) => change(l, status: RxStatus.error()),
      (r) {
        change(r, status: RxStatus.success());
        data = r;

        openAccount = data.openAccounts!.first;
        closedAccount = data.closedAccounts!.first;
      },
    );
    update();

    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void navigateToTotalOpenedAccounts() {
    Get.toNamed(Routes.totalAccountsOpened);
  }

  void navigateToEnableToSeeDataScreen() {
    Get.toNamed(Routes.enableToSeeData);
  }

  setOpenAccountValue(value) {
    openAccount = value;
    update();
  }

  setClosedAccountValue(value) {
    closedAccount = value;
    update();
  }
}
