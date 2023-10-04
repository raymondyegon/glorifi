import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../model/acc_screen_info_model.dart';

class ACCContainer extends StatefulWidget {
  final List<Widget> children;
  final FutureOr Function()? onContinue;
  final Widget? disclosureWidget;
  final bool showBackButton;
  final ACCScreenInfoModel info;
  final Function()? onBackTap;

  ACCContainer({
    required this.children,
    this.onContinue,
    this.disclosureWidget,
    this.showBackButton = true,
    required this.info,
    this.onBackTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ACCContainer> createState() => _ACCContainerState();
}

class _ACCContainerState extends State<ACCContainer> {
  final _formKey = GlobalKey<FormState>();
  bool _asyncProcessing = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.showBackButton,
      child: Scaffold(
        backgroundColor: GlorifiColors.bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _progressBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.info.subtitle != null) ...[
                      SizedBox(height: 21.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 28.h),
                        child: Text(
                          widget.info.subtitle!,
                          style: TextStyle(
                              color: GlorifiColors.defaultGradientStartColor, fontSize: 16),
                        ),
                      ),
                    ],
                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.children,
                            ),
                            SizedBox(height: 20.h),
                            if (widget.onContinue != null) _continueButton(),
                            if (widget.disclosureWidget != null)
                              widget.disclosureWidget!
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      color: GlorifiColors.headerBlue,
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
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            widget.info.title + "\n\n\n",
            maxLines: 2,
            style: headlineRegular30Primary(color: GlorifiColors.white),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  Widget _progressBar() => Container(
        color: GlorifiColors.lightBlue,
        width: widget.info.percentage / 100 * 1.sw,
        height: 8.h,
      );

  Widget _backButton() {
    return Ripple(
      onTap: () => {
        if (widget.onBackTap == null)
          {
            Get.back(),
          }
        else
          {
            widget.onBackTap!(),
          }
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: GlorifiColors.white,
      ),
    );
  }

  Widget _continueButton() {
    return Container(
      width: 1.sw,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r), // <-- Radius
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
                size: widget.info.showArrowOnCta ? 18.0 : 0,
                color: GlorifiColors.lightBlue),
        icon: Text(
          widget.info.ctaTitle,
          style: bodyBold18Primary(color: GlorifiColors.white),
        ), // <-- Text
      ),
    );
  }
}
