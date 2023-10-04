import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/feature/legal/controllers/legal_controller.dart';
import 'package:glorifi/src/feature/legal/views/legal_request_success.dart';
import 'package:glorifi/src/feature/legal/widgets/glorifi_webview.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/string_utils.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalDataRequestScreen extends GetView<LegalController> {
  final bool isDeleteRequest;
  const LegalDataRequestScreen({
    Key? key,
    required this.isDeleteRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: isDeleteRequest ? 'Request Data Deletion' : 'Request My Data',
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _explanation().paddingOnly(bottom: 24),
              _links().paddingOnly(bottom: 24),
              _card(title: "Personal Information", children: [
                _row('Name', profileController.getUserFullName()),
                _row('Email', profileController.userProfile.email ?? ''),
                _row(
                    'Phone Number',
                    profileController.userProfile.phoneNumber
                        .toPrettyPhoneNumberDisplay())
              ]),
              Spacer(),
              _requestButton(),
            ],
          ),
        ));
  }

  Widget _explanation() {
    return Text(
      'Consumers have a right to request access or deletion of personal information collected through GloriFi products and services. The completion of this form will initiate the process to request or delete data. You will receive a response to this request within 45 days. Requested data will be available for download for a period of 30 days or in the event data is deleted, a confirmation of deletion will be sent.',
      style: captionRegular14Primary(),
    );
  }

  Widget _links() {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
          text:
              'Learn more about how we collect and use your data to serve you in our ',
          style: captionRegular14Primary(color: GlorifiColors.black),
        ),
        _textSpanHyperLink(text: "Privacy Policy ", url: Urls.privacyPolicyUrl),
        TextSpan(
            text: "and ",
            style: captionRegular14Primary(color: GlorifiColors.black)),
        _textSpanHyperLink(
            text: "Terms and Conditions", url: Urls.termsAndConditionUrl),
      ],
    ));
  }

  Widget _row(String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Widget _card({
    required String title,
    String? subtitle,
    required List<Widget> children,
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
          if (subtitle != null) Text(subtitle),
          SizedBox(height: 20.h),
          ...children,
        ],
      ),
    );
  }

  TextSpan _textSpanHyperLink({required String text, required String url}) {
    return TextSpan(
      text: text,
      style: xSmallBold12Primary(color: GlorifiColors.darkBlue)
          .copyWith(height: 20 / 12),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (kIsWeb) {
            launch(url);
          } else {
            Get.to(() => GlorifiWebView(
                  title: text.capitalize!,
                  url: url,
                ));
          }
        },
    );
  }

  Widget _requestButton() {
    return CustomAsyncButton(
      onTap: () async {
        bool success;
        if (isDeleteRequest) {
          success = await controller.requestDataDeletion();
        } else {
          success = await controller.requestData();
        }
        if (success) {
          Get.to(() => LegalRequestSuccess());
        } else {
          _showRequestError(Get.context!);
        }
      },
      loadingWidget: _loadingButton(),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFF152951),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              "Send Request",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  Widget _loadingButton() {
    return Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF152951),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
  }

  _showRequestError(BuildContext context) {
    showDialog(context: context, builder: (ctx) => _alertDialog());
  }

  Widget _alertDialog() {
    return AlertDialog(
      title: Text(
          "There was an error processing your request. Please try again later."),
      titleTextStyle: bodyRegular18Primary(color: GlorifiColors.black),
      actions: [
        TextButton(
          child: Text(
            "Ok",
            style: TextStyle(color: GlorifiColors.black),
          ),
          onPressed: Get.back,
        ),
      ],
    );
  }
}
