import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/application_status_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class ACCController extends BaseController {
  final ACCService _accService = Get.put(ACCService());

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  /// Mock
  RxBool _mock = true.obs;

  void toggleMock(value) => _mock(value);

  bool get isMockEnabled => _mock.value;

  /// Create Deserve User and then Create Application
  /// TODO: Implement GetApplicationList API
  Future<void> initiateACC() async {
    if (isMockEnabled) {
      _pageStateController(PageState.SUCCESS);
      Get.toNamed(Routes.accPersonalInfo);
    } else {
      try {
        _pageStateController(PageState.LOADING);
        await _accService.createDeserveUser();
        await _accService.createApplicationId();

        /// TODO: getApplicationStatus needs more work, gotta discuss with John
        await _accService.getApplicationStatus(
          shouldInvokeCallback: true,
          callback: handleApplicationFlowBasedOnApplicationStatus,
        );
        _pageStateController(PageState.SUCCESS);
      } catch (e, stackTrace) {
        Log.debug(e.toString());
        Log.debug(stackTrace.toString());

        _pageStateController(PageState.ERROR);
        showErrorToast(e.toString());
      }
    }
  }

  /// TODO: Not to self: Very bad to handle navigation from Controller, FIX LATER
  Future<void> handleApplicationFlowBasedOnApplicationStatus() async {
    ApplicationStatusData _data = Get.find<ACCApplicationStatusModel>().data!;

    if (_data.status == "IN_PROGRESS" || _data.status == "PROVISIONING") {
      Get.toNamed(Routes.accApplicationInProgress);
    } else if (_data.status == "IN_REVIEW") {
      Get.toNamed(Routes.accApplicationInReview);
    } else if (_data.status == "PROVISIONED") {
      await Get.offNamedUntil(Routes.cockpit, (route) => false);
    } else if (_data.status == "APPLICANT_INPUT_REQUESTED") {
      if (_data.input == "CAPTURE_DATA") {
        Get.toNamed(Routes.accPersonalInfo);
      } else if (_data.input == "CREDIT_PULL_CONSENT") {
        /// TODO: Hit Application details API to get Users information
        Get.find<KYCController>().prefillTextFields();
        Get.toNamed(
          Routes.accResumeApplication,
          arguments: Routes.accReviewApplicationScreen,
        );
      } else if (_data.input == "PRODUCT_ACCEPTANCE") {
        Get.toNamed(
          Routes.accResumeApplication,
          arguments: Routes.accOfferBlueAndGoldCreditCardScreen,
        );
      } else {
        Get.toNamed(Routes.accNotApprovedScreen);
      }
    } else {
      Get.toNamed(Routes.accNotApprovedScreen);
    }
  }

  /*
  * CODE BELOW THIS SECTION WILL BE MOVED LATER
  */
  RxBool isConsentGiven = false.obs;

  RxBool isLoading = false.obs;

  acceptConsent(value) {
    isConsentGiven.value = value;
  }
}
