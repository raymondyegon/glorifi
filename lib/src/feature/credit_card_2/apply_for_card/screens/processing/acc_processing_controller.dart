import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/card_holder_agreement/controller/acc_agreement_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/controller/kyc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/review_application/acc_review_application_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class ACCProcessingController extends BaseController {
  final ACCController _accController = Get.find();
  final KYCController _kycController = Get.find();
  final ACCAgreementController _accAgreementController = Get.find();
  final ACCReviewApplicationController _reviewApplicationController =
      Get.find();

  /// Responsible for showing text under spinner
  RxString _message = "".obs;

  String get message => _message.value;

  /// Entrypoint flags
  bool _isFromAcceptCardHolderAgreementScreen = false;

  void toggleIsFromCardHolderAgreementScreen(value) =>
      _isFromAcceptCardHolderAgreementScreen = value;

  bool _isFromAddressVerificationScreen = false;

  void toggleIsFromAddressVerificationScreen(value) =>
      _isFromAddressVerificationScreen = value;

  Future initiateProcessing(Function(String path) callback) async {
    if (_isFromAddressVerificationScreen) {
      await _initiateStateAndAddressValidation(callback);
    } else if (_isFromAcceptCardHolderAgreementScreen) {
      await _initiateAcceptCardHolderAgreement(callback);
    } else {
      /// From Review your application screen
      await _initiateApplicationReview(callback);
    }
  }

  Future _initiateStateAndAddressValidation(Function callback) async {
    _message(TextConstants.verifyingInformation);
    toggleIsFromAddressVerificationScreen(false);
    if (_accController.isMockEnabled) {
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    if (_kycController.checkIfStateIsBlocked()) {
      Future.microtask(() => callback(Routes.accNotAvailableScreen));
    } else {
      await _kycController.validateAddressInformation();
      if (_kycController.pageState == PageState.SUCCESS)
        callback(Routes.accVerifySSN);
      else
        callback("POP");
    }
  }

  Future _initiateApplicationReview(Function callback) async {
    _message(TextConstants.processingYourApplication);
    if (_accController.isMockEnabled) {
      await Future.delayed(const Duration(milliseconds: 1500));
      callback(Routes.accOfferBlueAndGoldCreditCardScreen);
      return;
    }
    await _reviewApplicationController.initiateApplicationReviewProcess();
    if (_reviewApplicationController.pageState == PageState.SUCCESS)
      callback(Routes.accOfferBlueAndGoldCreditCardScreen);
    else
      callback(Routes.accNotApprovedScreen);
  }

  Future _initiateAcceptCardHolderAgreement(Function callback) async {
    _message(TextConstants.gettingYourNewCardReady);
    toggleIsFromCardHolderAgreementScreen(false);

    if (_accController.isMockEnabled) {
      await Future.delayed(const Duration(milliseconds: 1500));
      callback(Routes.accFrozenScreen);
    } else {
      await _accAgreementController.initiateCardHolderAgreement();
      if (_accAgreementController.pageState == PageState.ERROR) {
        callback(Routes.accNotApprovedScreen);
      }
    }
  }
}
