import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/feature/legal/widgets/glorifi_webview.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionText extends StatelessWidget {
  TermsAndConditionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final termsTextStyle = sansNormalStyle.copyWith(
      color: profileTextColor,
      fontSize: 12,
      height: 1.6,
    );

    return RichText(
      text: TextSpan(
          text: "By checking this box, I agree that I have read, understood and consent to ",
          style: termsTextStyle,
          children: [
            TextSpan(
                text: "GloriFi's Terms & Conditions",
                recognizer: TapGestureRecognizer()..onTap = _onTapTermsOfUse,
                style: termsTextStyle.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(text: ' and ', style: termsTextStyle),
            TextSpan(
                text: 'Privacy Policy.',
                recognizer: TapGestureRecognizer()..onTap = _onTapPrivacy,
                style: termsTextStyle.copyWith(fontWeight: FontWeight.bold)),
          ]),
    );
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
}
