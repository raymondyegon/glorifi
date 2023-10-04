import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_back_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_citizen_screen1.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_review_application_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

// Step 4 of 6
// https://app.asana.com/0/1202239119682092/1202240186732675/f
class OAOVerifyITINScreen extends GetView<OAOController> {
  const OAOVerifyITINScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => OAOContainer(
        children: _content(context),
        info: OAOScreensInfo.OAOVerifyITINScreen,
        disclosureWidget: OAOFooterNote(
          customText: TextSpan(children: [
            TextSpan(text: TextConstants.ssn_disclaimer1),
            TextSpan(text: '\n\n'),
            TextSpan(text: TextConstants.ssn_disclaimer2),
            TextSpan(text: '.'),
          ]),
        ),
        onContinue: () async {
          try {
            return controller.onConfirmSsn();
          } catch (error, trace) {
            OAOController.showGenericErrorSnackBar(context);
          }
        }));
  }

  List<Widget> _content(context) {
    return [
      GlorifiTextField(
        autofocus: true,
        initialValue: controller.applicationInProgress.value.ssn,
        label: "ITIN",
        showVisibilityOptions: true,
        keyboardType: TextInputType.numberWithOptions(),
        validator: GlorifiTextField.requiredSSN('ITIN'),
        inputFormatters: [
          CardFormatter(sample: "xxx-xx-xxxx", separator: "-"),
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
        ],
        onChanged: (value) {
          controller.applicationInProgress.value.ssn = value;
          // controller.application.isError(false);
        },
      ),
      // Obx(() => controller.application.isError.value
      //     ? Text(
      //         "Some information is invalid.",
      //         style: TextStyle(color: GlorifiColors.redError),
      //       )
      //     : SizedBox.shrink()),
      InkWell(
          child: Text(
            'I don\'t have it',
            style: TextStyle(
              color: GlorifiColors.midnightBlue,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () => Get.to(OAOBackScreen())).paddingOnly(top: 8, bottom: 8),
      OAOFooterNote(
          customText: TextSpan(children: [
        TextSpan(text: "By clicking continue, I confirm that I have read all of the "),
        TextSpan(
            text: "Tax Status Certifications Statements",
            style: xSmallBold12Primary(color: GlorifiColors.darkBlue).copyWith(height: 20 / 12),
            recognizer: infoModal(
                context, TextConstants.taxStatusCertificationsTitle, TextConstants.taxStatusCertificationsBody)),
        TextSpan(text: " and certify under penalties of perjury that they are true."),
      ])).paddingOnly(bottom: 20),
    ];
  }
}
