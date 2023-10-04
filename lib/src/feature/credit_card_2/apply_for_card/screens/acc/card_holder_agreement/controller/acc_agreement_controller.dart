import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/application_status_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class ACCAgreementController extends BaseController {
  final ACCService _accService = Get.find<ACCService>();

  /// Page State
  ///
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  /// Product Acceptance
  RxBool isProductAccepted = false.obs;

  /// Document Loading Flag
  RxBool isDocumentLoading = false.obs;

  /// Agreement Document
  PDFDocument? document;

  @override
  void onReady() async {
    super.onReady();
    _loadDocument();
  }

  void _loadDocument() async {
    isDocumentLoading.value = true;
    document = await PDFDocument.fromAsset(GlorifiAssets.checkDepositAgreement);
    isDocumentLoading.value = false;
  }

  /// Poll [getApplicationStatus] every 3 second for 2 minute tops, if
  /// [_data.status] is [IN_PROGRESS]. After 40 retries show error.
  int _retryCount = 1;

  Future<void> initiateCardHolderAgreement() async {
    _pageStateController(PageState.LOADING);
    try {
      if (_retryCount <= 40) {
        await _accService.getApplicationStatus();
        _retryCount++;
        ApplicationStatusData _data =
            Get.find<ACCApplicationStatusModel>().data!;

        if (_data.status == "IN_PROGRESS") {
          await Future.delayed(Duration(seconds: 3));
          initiateCardHolderAgreement();
          return;
        } else if (_data.input == "PRODUCT_ACCEPTANCE") {
          await _accService.acceptCardHolderAgreement();
          _resetRetryCounterAndCheckForStatus();
        } else {
          _retryCount = 1;
          Get.find<ACCController>()
              .handleApplicationFlowBasedOnApplicationStatus();
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
    initiateCardHolderAgreement();
    return;
  }
}
