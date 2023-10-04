import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class SubmitClaim extends StatelessWidget {
  const SubmitClaim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget dashGenerator({required int dashLength}) {
      return Flex(
        children: List.generate(dashLength, (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: SizedBox(
              width: 1,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(color: GlorifiColors.silver),
              ),
            ),
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.vertical,
      );
    }

    Widget roundedBg({required String asset}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: GlorifiColors.altoGrey),
        child: Center(
            child: SvgPicture.asset(
          asset,
          width: 24,
          height: 24,
          color: GlorifiColors.black,
        )),
      );
    }

    Widget contentTile(
        {required String asset,
        required String title,
        required String content,
        int dashLength = 5,
        bool generateDash = true}) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              roundedBg(asset: asset),
              if (generateDash)
                dashGenerator(
                  dashLength: dashLength,
                )
            ],
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: smallSemiBold16Primary(
                          color: GlorifiColors.cornflowerBlue)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    content,
                    style:
                        captionRegular14Primary(color: GlorifiColors.darkGrey),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget contactButton(
        {required String asset,
        required String header,
        required VoidCallback onTap}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
              color: GlorifiColors.white),
          child: Row(
            children: [
              SvgPicture.asset(
                asset,
                width: 24,
                height: 24,
                color: GlorifiColors.cornflowerBlue,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                header,
                style:
                    smallSemiBold16Primary(color: GlorifiColors.cornflowerBlue),
              )
            ],
          ),
        ),
      );
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      int dashes = sizingInfo.isDesktop
          ? 3
          : sizingInfo.isTablet
              ? 3
              : 5;
      return AdaptiveScaffold(
          backgroundColor: GlorifiColors.bgColor,
          appBar: GlorifiAppBar(
            title: "Claims",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.5.w,
                  vertical: !sizingInfo.isNativeMobile ? 50.h : 24.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: AdaptiveGrid(
                  children: [
                    AdaptiveGridItem(
                      desktop: 60,
                      tablet: 100,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizingInfo.isNativeMobile ? 16.w : 0,
                                  right: sizingInfo.isNativeMobile ? 48.w : 0),
                              child: Text(
                                "Filing a Claim? Here’s Our Process",
                                style: leadRegular24Secondary(
                                        color: GlorifiColors.cornflowerBlue)
                                    .copyWith(height: 1.6),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    AdaptiveGridItem(
                      desktop: 50,
                      tablet: 100,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.r),
                                color: GlorifiColors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              child: Column(
                                children: [
                                  contentTile(
                                      asset: "assets/images/phone_call.svg",
                                      title: "Contact us",
                                      dashLength: dashes,
                                      content:
                                          "We’ll assign a dedicated Claims personal to help you right from the start and begin gathering details about your claim."),
                                  contentTile(
                                      asset: "assets/images/file_text.svg",
                                      dashLength: dashes + 1,
                                      title:
                                          "Glorifi creates a record of your claim",
                                      content:
                                          "We’ll send you what’s called a First Notice of Loss Acknowledgment (FNOL). It’s the initial report that starts the formal process of your claim."),
                                  contentTile(
                                      asset: "assets/images/user_check.svg",
                                      title: "Glorifi assigns an adjuster",
                                      content:
                                          "Your dedicated Claims Concierge will assign an adjuster to your claim.",
                                      generateDash: false),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    AdaptiveGridItem(
                      desktop: 50,
                      tablet: 100,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizingInfo.isDesktop ? 30.w : 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text("File a Claim",
                                  style: headlineRegular21Secondary(
                                      color: GlorifiColors.cornflowerBlue)),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            contactButton(
                                asset: "assets/icons/phone_icon.svg",
                                header: "555 555-5555",
                                onTap: () {}),
                            SizedBox(
                              height: 10.h,
                            ),
                            contactButton(
                                asset: "assets/images/external_link.svg",
                                header: "nas.glorifi.com",
                                onTap: () {}),
                            SizedBox(
                              height: 32.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                "Submitted a Claim?",
                                style: headlineRegular21Secondary(
                                    color: GlorifiColors.cornflowerBlue),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                "Be on the look out for a call or email from an \nadjuster.",
                                style: captionRegular14Primary(
                                    color: GlorifiColors.darkGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
