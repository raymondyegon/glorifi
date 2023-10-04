import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/legal/models/legal_item.dart';
import 'package:glorifi/src/feature/legal/models/legal_section.dart';
import 'package:glorifi/src/feature/legal/models/settings_name.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LegalController extends GetxController {
  final RxList<LegalSection> _settingsSectionController = RxList();
  List<LegalSection> get settingSections =>_settingsSectionController.toList();
  final _apiHelper = DataHelperImpl.instance.apiHelper;

  final  _appVersionController = "".obs;
  String get appVersion => _appVersionController.value;

  @override
  void onInit() {
    _prepareSettingsItem();
    _initAppVersion();

    super.onInit();
  }

  _initAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersionController('${packageInfo.version} (${packageInfo.buildNumber})');
  }

  _prepareSettingsItem() async {
    final List<LegalSection> settingsItems = [];

    settingsItems.add(_getLegalSectionSetting());
    settingsItems.add(_getProductsTermsSectionSetting());
    settingsItems.add(_getBankingTermsOfUseSettings());
    settingsItems.add(_getPersonalDataSettings());
    settingsItems.add(_getContactUsSectionSetting());

    _settingsSectionController(settingsItems);
  }

  LegalSection _getContactUsSectionSetting() {
    final glorifiWebSettings = LegalItem(
        title: 'GloriFi.com',
        settingsName: SettingsName.GLORIFI,
        isLastElement: true);

    return LegalSection(title: "Website", settingItems: [glorifiWebSettings]);
  }

  LegalSection _getLegalSectionSetting() {
    final termsOfUse = LegalItem(
        title: 'Terms & Conditions',
        settingsName: SettingsName.TERMS,
        isLastElement: false);
    final privacy = LegalItem(
      title: 'Privacy Policy',
      settingsName: SettingsName.PRIVACY,
      isLastElement: true,
    );

    return LegalSection(
      title: "Legal",
      settingItems: [
        termsOfUse,
        privacy,
      ],
    );
  }

  LegalSection _getProductsTermsSectionSetting() {
    final financialTermsOfUse = LegalItem(
        title: 'Financial Terms of Use',
        settingsName: SettingsName.FINANCIAL_TERMS,
        isLastElement: false);
    final cardholderService = LegalItem(
        title: 'Cardholder Services',
        settingsName: SettingsName.CARDHOLDER_SERVICE,
        isLastElement: false);
    final businessService = LegalItem(
      title: 'Business Access Services',
      settingsName: SettingsName.BUSINESS_SERVICES,
      isLastElement: true,
    );

    return LegalSection(
      title: "Products Terms of use",
      settingItems: [
        financialTermsOfUse,
        cardholderService,
        businessService,
      ],
    );
  }

  LegalSection _getBankingTermsOfUseSettings() {
    final freeSchedule = LegalItem(
      title: 'Fee Schedule',
      settingsName: SettingsName.FREE_SCHEDULE,
      isLastElement: false,
    );

    final consentToEmailsSms = LegalItem(
      title: 'Consent to emails sms',
      settingsName: SettingsName.CONSENT_TO_EMAILS_SMS,
      isLastElement: false,
    );

    final onlineBankingAgreement = LegalItem(
      title: 'Online banking agreement',
      settingsName: SettingsName.ONLINE_BANKING_AGREEMENT,
      isLastElement: false,
    );

    final accountInformationDisclosures = LegalItem(
      title: 'Account Information Disclosures',
      settingsName: SettingsName.ACCOUNT_INFORMATION_DISCLOSURES,
      isLastElement: true,
    );

    return LegalSection(
      title: 'Banking Terms of use',
      settingItems: [
        freeSchedule,
        consentToEmailsSms,
        onlineBankingAgreement,
        accountInformationDisclosures,
      ],
    );
  }

  LegalSection _getPersonalDataSettings() {
    final requestMyData = LegalItem(
      title: 'Request my data',
      settingsName: SettingsName.REQUEST_MY_DATA,
      isLastElement: false,
    );

    final requestDataDeletion = LegalItem(
      title: 'Request data deletion',
      settingsName: SettingsName.REQUEST_DATA_DELETION,
      isLastElement: true,
    );

    return LegalSection(
      title: 'Personal Data',
      settingItems: [
        requestMyData,
        requestDataDeletion,
      ],
    );
  }

  // Request all user data be deleted
  Future<bool> requestDataDeletion() async {
    try {
      final response = await _apiHelper.legalDataRequest(true);
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }

  // Request a copy of all user data
  Future<bool> requestData() async {
    try {
      final response = await _apiHelper.legalDataRequest(false);
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
