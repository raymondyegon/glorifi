import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class NoLinkedAccount extends StatelessWidget {
  const NoLinkedAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) => Padding(
        padding: EdgeInsets.only(left: 0,
            right: 0, bottom: sizingInfo.isDesktop ? 110.0 : 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: sizingInfo.isNativeMobile ? 0.h : 64.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 48.h,
                horizontal: sizingInfo.isNativeMobile ? 0 : 50.w,
              ),
              decoration: BoxDecoration(
                color: GlorifiColors.primaryButtonProgressColor,
                borderRadius:
                    BorderRadius.circular(sizingInfo.isNativeMobile ? 0 : 8),
              ),
              child: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                  ? Container(
                      height: 1250.h,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: TextNoLinked(
                                  isNativeMobile: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile))),
                          Flexible(
                            child: ImagesNoLInked(
                              isNativeMobile: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile),
                            ),
                          ),
                          GoLinkBank(isNativeMobile: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 10,
                          child:  TextNoLinked(),
                        ),
                        Expanded(
                          flex: 11,
                          child: ImagesNoLInked(),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagesNoLInked extends StatelessWidget {
  const ImagesNoLInked({
    this.isNativeMobile = false,
    Key? key,
  }) : super(key: key);

  final bool isNativeMobile;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: isNativeMobile ? 750.h : 1050.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: isNativeMobile ? 40 : 70,
            child: Transform(
              transform: Matrix4.identity()..setEntry(3, 2, 1),
              child: Image.asset(
                'assets/images/insight-card-2.png',
              ),
            ),
          ),
          Positioned(
            top: 170,
            left: 0,
            child: Transform(
              transform: Matrix4.identity()..setEntry(3, 2, 2),
              child: Image.asset(
                'assets/images/insight-card-4.png',
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 210,
            child: Transform(
              transform: Matrix4.identity()..setEntry(3, 2, 3),
              child: Image.asset(
                'assets/images/insight-card.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextNoLinked extends StatelessWidget {
  TextNoLinked({
    this.isNativeMobile = false,
    Key? key,
  }) : super(key: key);

  final bool isNativeMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/brand-mark.svg',
                width: 46.52.w,
                height: 14.91.h,
              ),
              SizedBox(width: 14.48.w),
              Text(
                'GloriFi Financial Insights',
                style: bodySemiBold18Primary(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: isNativeMobile ? 39.h : 60.h),
          Text(
            'See over 60 relevant personal financial insights',
            style: isNativeMobile ? headlineBold31Primary(
              color: Colors.white,
            ) : headlineBold37Secondary(
              color: Colors.white,
            ),
          ),
          SizedBox(height: isNativeMobile ? 28.h : 45.h),
          Text(
            '• Build sound financial habits',
            style: bodyRegular18Primary(
              color: Colors.white,
            ),
          ),
          SizedBox(height: isNativeMobile ? 16.h : 30.h),
          Text(
            '• Track spending with fraud alerts',
            style: bodyRegular18Primary(
              color: Colors.white,
            ),
          ),
          SizedBox(height: isNativeMobile ? 16.h : 30.h),
          Text(
            '• Discover new opportunities to invest and save',
            style: bodyRegular18Primary(
              color: Colors.white,
            ),
          ),
          SizedBox(height: isNativeMobile ? 20.h : 140.h),
          isNativeMobile
              ? SizedBox()
              : Column(
                  children: [
                    GoLinkBank(isNativeMobile: isNativeMobile),
                    SizedBox(height: 111.h),
                  ],
                ),
        ],
      ),
    ).paddingOnly(top:isNativeMobile ? 0 : 25);
  }
}

class GoLinkBank extends StatelessWidget {
  const GoLinkBank({
    this.isNativeMobile = false,
    Key? key,
  }) : super(key: key);
  final bool isNativeMobile;
  @override
  Widget build(BuildContext context) {
    PlaidController plaidController = Get.put(PlaidController());
    return InkWell(
      onTap: () async {
        await plaidController.openPlaid();
      },
      child: Container(
        width: 342.w,
        height: isNativeMobile ? 64.h : 84.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/personal_snapshot/link_bank_account.svg',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 8.w),
            Text(
              'Link a Bank Account',
              style: bodyBold18Primary(),
            )
          ],
        ),
      ),
    );
  }
}
