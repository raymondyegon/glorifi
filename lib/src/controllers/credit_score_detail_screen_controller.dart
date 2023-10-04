import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/DeveloperOptionsController.dart';
import '../core/data_helper.dart';
import '../core/exceptions/custom_exception.dart';
import '../feature/personal_snapshot/compare/compare_value.dart';
import '../model/credit_score_model.dart';

class CreditScoreDetailScreenController extends GetxController with StateMixin {
  final _dataHelper = DataHelperImpl.instance;
  Rx<CreditScoreModel> creditScoreModel = CreditScoreModel().obs;

  var error = "".obs;

  Future<void> getCreditScore() async {
    DeveloperOptionsController _controller =
        Get.find<DeveloperOptionsController>();
    if (_controller.isMockedCreditScoreEnabled.isTrue) {
      final response = await _dataHelper.mockApiHelper.getCreditScore();
      response.fold(
          (error) => change(setError(error), status: RxStatus.error()),
          (success) =>
              change(setCreditScore(success), status: RxStatus.success()));
    } else {
      final response = await _dataHelper.apiHelper.getCreditScore();
      response.fold(
          (error) => change(setError(error), status: RxStatus.error()),
          (success) =>
              change(setCreditScore(success), status: RxStatus.success()));
    }
  }

  setCreditScore(CreditScoreModel model) {
    creditScoreModel.value = model;
  }

  setError(CustomException error) {
    this.error.value = error.errorMessage;
  }

  openComparison() {
    Get.bottomSheet(
      CompareValueScreen(
        gloriFiCompareState: GloriFiCompareType.creditScore,
        member: creditScoreModel.value.data!.creditTotal?.value.toString(),
      ),
      barrierColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );
  }
}
