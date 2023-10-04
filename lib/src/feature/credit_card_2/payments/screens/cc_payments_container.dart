import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class CCPaymentsContainer extends StatefulWidget {
  final List<Widget> children;
  final FutureOr Function()? onContinue;
  final FutureOr Function()? onSkip;

  final Widget? disclosureWidget;
  final bool showBackButton;
  final String title;
  final bool showArrowOnCta;
  final String? ctaTitle;

  CCPaymentsContainer({
    required this.children,
    this.onContinue,
    this.onSkip,
    this.disclosureWidget,
    this.showBackButton = true,
    this.showArrowOnCta = true,
    this.ctaTitle,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<CCPaymentsContainer> createState() => _CCPaymentsContainerState();
}

class _CCPaymentsContainerState extends State<CCPaymentsContainer> {
  final _formKey = GlobalKey<FormState>();
  bool _asyncProcessing = false;

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        color: GlorifiColors.white,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20.h,
          right: 20.w,
          left: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.showBackButton) _backButton(),
                Spacer(),
                if (widget.onSkip != null) _skipButton(),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              widget.title + "\n\n\n",
              maxLines: 2,
              style: headlineRegular30Primary(color: GlorifiColors.black),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      );
    }

    return WillPopScope(
        child: Scaffold(
            backgroundColor: GlorifiColors.superLightGrey,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: widget.children),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (widget.onContinue != null &&
                                      widget.ctaTitle != null)
                                    _continueButton(),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  if (widget.disclosureWidget != null)
                                    widget.disclosureWidget!
                                        .paddingOnly(bottom: 40, right: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
        onWillPop: () async => widget.showBackButton);
  }

  Widget _backButton() {
    return Ripple(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: GlorifiColors.black,
      ),
    );
  }

  Widget _skipButton() {
    return Ripple(
      onTap: () async {
        await widget.onSkip!();
      },
      child: Text(
        "Skip",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }

  Widget _continueButton() {
    return Container(
      width: 1.sw,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          primary: Colors.white,
          backgroundColor: GlorifiColors.darkBlueTint[700],
          padding: EdgeInsets.all(24),
        ),
        onPressed: _asyncProcessing
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    _asyncProcessing = true;
                    setState(() {});
                    await widget.onContinue!();
                  } finally {
                    _asyncProcessing = false;
                    setState(() {});
                  }
                }
              },
        label: _asyncProcessing
            ? SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  color: Colors.white54,
                ),
              ).paddingOnly(left: 10)
            : Icon(Icons.arrow_forward,
                size: widget.showArrowOnCta ? 18.0 : 0,
                color: GlorifiColors.lightBlue),
        icon: Text(
          widget.ctaTitle!,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ), // <-- Text
      ),
    );
  }
}
