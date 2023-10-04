import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:get/state_manager.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

import '../../../../core/data_helper.dart';

class CheckDepositController extends BaseController {
  var hasConsented = false.obs;
  var isLoading = true.obs;
  PDFDocument? document;

  @override
  void onInit() {
    super.onInit();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset(GlorifiAssets.checkDepositAgreement);
    isLoading.value = false;
  }

  saveUserAcceptance() async {
    await DataHelperImpl.instance.cacheHelper.saveUserTermsAcceptance(true);
  }
}
