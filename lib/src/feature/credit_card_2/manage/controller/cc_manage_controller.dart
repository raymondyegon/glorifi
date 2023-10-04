import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/model/cc_manage_card_data_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class CCManageController extends BaseController {
  var switchValue = [false, true].obs;

  RxList<CCManageCardDataModel> security = <CCManageCardDataModel>[].obs;

  RxList<CCManageCardDataModel> payment = <CCManageCardDataModel>[].obs;

  RxList<CCManageCardDataModel> account = <CCManageCardDataModel>[].obs;

  RxList<CCManageCardDataModel> help = <CCManageCardDataModel>[].obs;

  RxList<CCManageCardDataModel> accountDocuments =
      <CCManageCardDataModel>[].obs;

  RxList<CCManageCardDataModel> legalDocuments = <CCManageCardDataModel>[].obs;

  @override
  void onInit() {
    _populateSecurityCardData();
    _populatePaymentCardData();
    _populateAccountCardData();
    _populateHelpCardData();
    _populateAccountDocumentsCardData();
    _populateLegalDocumentsCardData();
    super.onInit();
  }

  changeSwitch(bool value, int index) {
    switchValue[index] = value;
  }

  _populateSecurityCardData() {
    security.add(
      CCManageCardDataModel("Freeze my card", "lock", true),
    );
    security.add(
      CCManageCardDataModel("Enable card usage abroad", "internet", true),
    );
    security.add(
      CCManageCardDataModel("Report a lost or stolen card", "lost_card", false),
    );
  }

  _populatePaymentCardData() {
    payment.add(
      CCManageCardDataModel("Manage Auto Pay Schedule", "schedule", false),
    );
  }

  _populateAccountCardData() {
    account.add(
      CCManageCardDataModel("Update Contact Information", "profile", false),
    );
    account.add(
      CCManageCardDataModel(
          "View credit limit and APR", "circular_info", false),
    );
  }

  _populateHelpCardData() {
    help.add(
      CCManageCardDataModel("FAQs and Support", "circular_info", false),
    );
  }

  _populateAccountDocumentsCardData() {
    accountDocuments.add(
      CCManageCardDataModel(
          "Mastercard World Elite Benefits Terms & Conditions", "", false),
    );
    accountDocuments.add(
      CCManageCardDataModel("Cardholder Agreement", "", false),
    );
  }

  _populateLegalDocumentsCardData() {
    legalDocuments.add(
      CCManageCardDataModel("USA PATRIOT Act Notice", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("Terms & Conditions", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("Privacy Notice", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("GloriFi's Privacy Policy", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("Deserve, Inc.'s Privacy Policy", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("Electronic Consent Agreement", "", false),
    );
    legalDocuments.add(
      CCManageCardDataModel("ACH Authorization", "", false),
    );
  }
}
