import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_deposit_account.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_disclosure.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_complete_account_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/feature/legal/widgets/glorifi_webview.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// Step 5 of 6
// https://app.asana.com/0/1202239119682092/1202240186732679/f

class OAOReviewApplicationScreen extends StatefulWidget {
  OAOReviewApplicationScreen({Key? key}) : super(key: key);

  @override
  State<OAOReviewApplicationScreen> createState() =>
      _OAOReviewApplicationScreenState();
}

class _OAOReviewApplicationScreenState
    extends State<OAOReviewApplicationScreen> {
  OAOController controller = Get.find();
  bool error1 = false;

  updateErrorMessage({bool showError: false}) {
    if (showError || error1) {
      setState(() {
        error1 = !controller
            .application.authorizations[OAOAuthorizations.allDisclosures]!;
      });
    }
  }

  String dateNow() {
    var now = DateTime.now();
    return DateFormat.yMd().format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return OAOContainer(
        info: OAOScreensInfo.OAOReviewApplicationScreen,
        children: _content(),
        disclosureWidget: OAOFooterNote(
          customText: TextSpan(
            children: [
              TextSpan(text: TextConstants.reviewDisclosure + "\n\n"),
              TextSpan(text: TextConstants.ratesDisclosure),
              TextSpan(text: dateNow()),
              TextSpan(text: TextConstants.ratesDisclosure1),
              textSpanHyperLink(
                  text: "rate sheet", url: "https://glorifi.com/rates/"),
            ],
          ),
        ).paddingOnly(bottom: 40),
        onContinue: () async {
          try {
            updateErrorMessage(showError: true);
            if (error1) {
              return;
            }
            await controller.onSubmitApplication();
            if (controller.application.isError.value) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        actions: <Widget>[
                          PrimaryButton(
                              title: "close",
                              width: 294.w,
                              height: 64.h,
                              primaryColor: GlorifiColors.primaryDarkButtonColor,
                              textColor: GlorifiColors.primaryDarkButtonTextColor,
                              onTap: () => Navigator.pop(context)),
                        ],
                        title: Text("Could not create account"),
                        content: SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            Text("Please review your information and try again"),
                          ],
                        )));
                  });
            }
          } catch (error) {
            OAOController.showGenericErrorSnackBar(context);
          }
        },
      );
    });
  }

  List<Widget> _row(String name, String value) {
    return [
      Text(
        name,
        style: TextStyle(
          color: GlorifiColors.darkBlueColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        value,
        style: TextStyle(fontSize: 14, height: 1.6),
      ),
      SizedBox(
        height: 20.h,
      )
    ];
  }

  Widget _card({
    required String title,
    required List<Widget> children,
    String? errorMessage,
    bool? showError,
    Widget? footer,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: GlorifiColors.black.withOpacity(.080),
            // spreadRadius: 5,
          )
        ],
      ),
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: GlorifiColors.darkBlueColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20.h),
          ...children,
          showError != null && showError && errorMessage != null
              ? Text(
                  errorMessage,
                  style: TextStyle(color: GlorifiColors.redError),
                )
              : SizedBox.shrink(),
          if (footer != null) footer.paddingOnly(top: 10.h)
        ],
      ),
    );
  }

  List<Widget> _needToKnow() {
    return [
      _megaDisclosure(),
    ];
  }

  List<Widget> _content() {
    var formatter = DateFormat.yMMMMd('en_US');
    return [
      CardImage(product: controller.application.selectedProduct!),
      SizedBox(
        height: 20.h,
      ),
      _card(
        title: "Personal Details",
        children: [
          ..._row(
            "Name",
            controller.application.fullName,
          ),
          ..._row(
              "Date of Birth", formatter.format(controller.application.dob!)),
          ..._row("Phone Number", controller.application.phoneNumber!),
          ..._row(
            "Permanent Physical Address",
            controller.application.address.formatted,
          ),
          ..._row(
              "Mailing Address",
              !controller.application.hasMailingAddress
                  ? controller.application.address.formatted
                  : controller.application.mailingAddress.formatted),
          ..._row(
            "Citizenship",
            "✓ ${controller.application.USCitizenship}\n" +
                controller.application.nonUSCitizenship
                    .map((element) => "✓ " + element + " Citizen")
                    .join("\n"),
          ),
        ],
      ),
      _card(
        title: "What you need to know",
        errorMessage: "Please accept all disclosures",
        showError: error1,
        children: _needToKnow(),
        footer: OAOFooterNote(
          customText: TextSpan(
            children: [
              TextSpan(
                text: TextConstants.oaoContactConsent,
              ),
              TextSpan(
                text: TextConstants.oaoContactConsent1,
                style: TextStyle(color: GlorifiColors.darkBlue),
              ),
              TextSpan(
                text: TextConstants.oaoContactConsent2,
              )
            ],
          ),
        ),
      )
    ];
  }

  Widget _megaDisclosure() {
    _onDisclosureTap(OAODisclosure disclosure) {
      if (kIsWeb) {
        launch(disclosure.url);
      } else {
        Get.to(
          GlorifiWebView(title: disclosure.title, url: disclosure.url),
        );
      }
    }

    List<TextSpan> _generateHyperlinks() {
      var text_spans = controller.productDisclosures.asMap().entries.map(
        (entry) {
          return TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => _onDisclosureTap(entry.value),
            text: entry.key == controller.productDisclosures.length - 1
                ? entry.value.title
                : entry.value.title + ', ',
            style: TextStyle(
              color: GlorifiColors.darkBlue,
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ).toList();

      if (text_spans.length > 1) {
        text_spans.insert(
          controller.productDisclosures.length - 1,
          TextSpan(
            text: 'and ',
            style: TextStyle(color: GlorifiColors.black),
          ),
        );
      }
      return text_spans;
    }

    return Obx(
      () => GloriFiCheckBox(
        child: RichText(
          text: TextSpan(
            style: TextStyle(height: 1.4),
            children: [
              TextSpan(
                text: "I confirm I have read and accept: ",
                style: TextStyle(color: GlorifiColors.black),
              ),
              ..._generateHyperlinks()
            ],
          ),
        ),
        onChanged: (bool? checked) {
          if (checked != null) {
            controller.application.authorizations[OAOAuthorizations.allDisclosures] = checked;
          }
          updateErrorMessage();
        },
        checked: controller.application.authorizations[OAOAuthorizations.allDisclosures]!,
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  final OAODepositAccount product;

  const CardImage({required this.product, Key? key}) : super(key: key);

  Widget _sm() => Text(
        " SM",
        style: TextStyle(
          fontSize: 7,
          height: 0.9,
          fontWeight: FontWeight.w700,
          color: GlorifiColors.white,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: GlorifiColors.darkBlueTint[700],
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 15,
              color: GlorifiColors.black.withOpacity(.30),
            )
          ]),
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      height: 114.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.accountTypeDisplayString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ).paddingOnly(top: 22.h),
              SizedBox(height: 21.h),
              Text(
                "APY ${product.apy}*",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ).paddingOnly(bottom: 15)
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  GlorifiAssets.glorifiLogo,
                  height: 24,
                ),
                _sm(),
              ],
            ),
          ).paddingOnly(top: 30)
        ],
      ),
    );
  }
}
