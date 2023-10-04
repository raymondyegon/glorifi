import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/application_status_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class ACCReviewApplicationController extends BaseController {
  final ACCService _accService = Get.find();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  /// Electronic Consent Agreement
  RxBool isElectronicConsentAgreement = false.obs;

  /// Privacy Policy
  RxBool isPrivacyPolicy = false.obs;

  /// Soft Credit Pull Consent
  RxBool isSoftCreditPullConsent = false.obs;

  /// Enable Submit Application Button
  /// TODO: Will do later

  /// Poll [getApplicationStatus] every 3 second for 2 minute tops, if
  /// [_data.status] is [IN_PROGRESS]. After 40 retries show error.
  int _retryCount = 1;

  Future<void> initiateApplicationReviewProcess() async {
    _pageStateController(PageState.LOADING);
    try {
      if (_retryCount <= 40) {
        await _accService.getApplicationStatus();
        _retryCount++;
        ApplicationStatusData _data =
            Get.find<ACCApplicationStatusModel>().data!;

        if (_data.status == "IN_PROGRESS") {
          await Future.delayed(Duration(seconds: 3));
          initiateApplicationReviewProcess();
          return;
        } else if (_data.status == "APPLICANT_INPUT_REQUESTED") {
          if (_data.input == "CAPTURE_DATA") {
            /// Update Applicant Data
            await _accService.updateApplicantData();

            /// If [updateApplicantData] is successful, then we need to check
            /// for status again to decide our next step
            _resetRetryCounterAndCheckForStatus();
          } else if (_data.input == "CREDIT_PULL_CONSENT") {
            /// Update Credit Pull Consent
            await _accService.updateCreditPullConsent();
            /// TODO: Implement Eligible Product Info
            /// If [updateCreditPullConsent] is successful, then we need to check
            /// for status again to decide our next step
            _resetRetryCounterAndCheckForStatus();
          } else if (_data.input == "PRODUCT_ACCEPTANCE") {
            _retryCount = 1;
            _pageStateController(PageState.SUCCESS);
          } else {
            _onErrorResetCounterAndGetOut();
          }
          return;
        } else {
          _onErrorResetCounterAndGetOut();
          return;
        }
      } else {
        _onErrorResetCounterAndGetOut();
        return;
      }
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      _onErrorResetCounterAndGetOut();
      return;
    }
  }

  void _onErrorResetCounterAndGetOut() {
    _pageStateController(PageState.ERROR);
    _retryCount = 1;
  }

  void _resetRetryCounterAndCheckForStatus() {
    _retryCount = 1;
    initiateApplicationReviewProcess();
    return;
  }
}
