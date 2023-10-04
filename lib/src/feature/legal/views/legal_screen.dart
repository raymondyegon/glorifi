import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/feature/legal/controllers/legal_controller.dart';
import 'package:glorifi/src/feature/legal/models/legal_item.dart';
import 'package:glorifi/src/feature/legal/models/legal_section.dart';
import 'package:glorifi/src/feature/legal/models/settings_name.dart';
import 'package:glorifi/src/feature/legal/views/legal_data_request_screen.dart';
import 'package:glorifi/src/feature/legal/widgets/glorifi_webview.dart';
import 'package:glorifi/src/feature/legal/widgets/legal_item_view.dart';
import 'package:glorifi/src/feature/legal/widgets/legal_section_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalScreen extends GetView<LegalController> {
  LegalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: TextConstants.privacyAndTerms,
        elevation: 0,
      ),
      backgroundColor: GlorifiColors.white,
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1024),
                  child: AdaptiveGrid(
                    gridSpacing: 32.w,
                    children: [
                      AdaptiveGridItem(
                        nativeMobile: 100,
                        webMobile: 100,
                        desktop: 50,
                        tablet: 60,
                        child: (!sizingInfo.isWebMobile &&
                                !sizingInfo.isNativeMobile)
                            ? Container(
                                padding: EdgeInsets.only(
                                  top: 64.h,
                                  bottom: 94.h,
                                  left: 208.w,
                                ),
                                //color: GlorifiColors.lighterGrey,
                                child: Text(
                                  TextConstants.policiesAndTerms,
                                  style: headlineRegular37Secondary(
                                    color: GlorifiColors.cornflowerBlue,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                _getSettingsList(sizingInfo),
                AdaptiveGrid(
                  gridSpacing: 32.w,
                  children: [
                    AdaptiveGridItem(
                      nativeMobile: 100,
                      webMobile: 100,
                      desktop: 100,
                      tablet: 100,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 36.h,
                          horizontal: sizingInfo.isDesktop
                              ? 208.w
                              : sizingInfo.isTablet
                                  ? 32.w
                                  : 24.w,
                        ),
                        alignment: (sizingInfo.isDesktop)
                            ? Alignment.centerLeft
                            : Alignment.center,
                        child: Obx(
                          () => Column(
                            children: [
                              Text(
                                "App Version ${controller.appVersion}",
                                style: smallRegular16Primary(
                                  color: GlorifiColors.darkBlue,
                                ),
                              ).paddingOnly(
                                bottom: sizingInfo.isDesktop ? 24.h : 150.h,
                              ),
                              if (sizingInfo.isDesktop)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        TextConstants.policiesAndTermsDetails,
                                        style: xSmallRegular12Primary(
                                            color: GlorifiColors
                                                .midnightBlueColor),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _getSettingsList(AdaptiveSizingInfo sizingInfo) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizingInfo.isDesktop ? 208.w : 32.w,
        ),
        child: AdaptiveGrid(
          gridSpacing: sizingInfo.isDesktop ? 32.w : 0,
          children: controller.settingSections
              .map((e) => _settingSection(e, sizingInfo))
              .toList(),
        ),
      ),
    );
  }

  AdaptiveGridItem _settingSection(
      LegalSection settingSection, AdaptiveSizingInfo sizingInfo) {
    return AdaptiveGridItem(
      nativeMobile: 100,
      webMobile: 100,
      tablet: 100,
      desktop: 50,
      child: LegalSectionContainer(
              title: settingSection.title,
              children: settingSection.settingItems
                  .map((e) => _getSettingItemWidgetFromModel(e, sizingInfo))
                  .toList())
          .marginOnly(bottom: 40.h),
    );
  }

  LegalItemView _getSettingItemWidgetFromModel(
      LegalItem settingsItem, AdaptiveSizingInfo sizingInfo) {
    return LegalItemView(
      title: settingsItem.title,
      isLastElement: settingsItem.isLastElement,
      sizingInfo: sizingInfo,
      onTap: settingItemOnTap(settingsItem.settingsName),
    );
  }

  Function()? settingItemOnTap(SettingsName settingsName) {
    switch (settingsName) {
      case SettingsName.GLORIFI:
        return _onTapWebItems;

      case SettingsName.TERMS:
        return _onTapTermsOfUse;

      case SettingsName.PRIVACY:
        return _onTapPrivacy;

      case SettingsName.FINANCIAL_TERMS:
        return _onTapFinancialTermsOfUse;

      case SettingsName.CARDHOLDER_SERVICE:
        return _onTapCardholderService;

      case SettingsName.BUSINESS_SERVICES:
        return _onTapBusinessAccessService;

      case SettingsName.FREE_SCHEDULE:
        return _onTapFeeSchedule;

      case SettingsName.CONSENT_TO_EMAILS_SMS:
        return _onTapConsentToEmailsSms;

      case SettingsName.ONLINE_BANKING_AGREEMENT:
        return _onTapOnlineBankingAgreement;

      case SettingsName.ACCOUNT_INFORMATION_DISCLOSURES:
        return _onTapAccountInformationDisclosures;

      case SettingsName.REQUEST_MY_DATA:
        return _onTapRequestMyData;

      case SettingsName.REQUEST_DATA_DELETION:
        return _onTapRequestDataDeletion;

      default:
        return null;
    }
  }

  void _onTapWebItems() {
    Get.to(GlorifiWebView(title: "GloriFi.com", url: "https://glorifi.com"));
  }

  void _onTapTermsOfUse() {
    if (kIsWeb) {
      launch(Urls.termsAndConditionUrl);
    } else {
      Get.to(GlorifiWebView(
        title: "Terms & Conditions",
        url: Urls.termsAndConditionUrl,
      ));
    }
  }

  void _onTapPrivacy() {
    if (kIsWeb) {
      launch(Urls.privacyPolicyUrl);
    } else {
      Get.to(GlorifiWebView(
        title: "Privacy Policy",
        url: Urls.privacyPolicyUrl,
      ));
    }
  }

  void _onTapFinancialTermsOfUse() {
    showSnackBar("on tap Financial Terms of Use");
  }

  void _onTapCardholderService() {
    showSnackBar("on tap Cardholder Service");
  }

  void _onTapBusinessAccessService() {
    showSnackBar("on tap Business Access Service");
  }

  void _onTapFeeSchedule() {
    showSnackBar("on tap Fee Schedule");
  }

  void _onTapConsentToEmailsSms() {
    showSnackBar("On tap Consent to emails sms");
  }

  void _onTapOnlineBankingAgreement() {
    showSnackBar("Online banking agreement");
  }

  void _onTapAccountInformationDisclosures() {
    showSnackBar("On tap Account Information Disclosures");
  }

  void _onTapRequestMyData() {
    Get.to(() => LegalDataRequestScreen(isDeleteRequest: false));
  }

  void _onTapRequestDataDeletion() {
    Get.to(() => LegalDataRequestScreen(isDeleteRequest: true));
  }
}
