import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/mortgage_pre_apply_screen.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';
import '../../routes/app_pages.dart';
import '../../widgets/buttons/primary_buton_dark.dart';
import '../cockpit/controllers/cockpit_controller.dart';
import 'controller/credit_card_controller.dart';

class CreditCardComingSoon extends StatelessWidget {
  const CreditCardComingSoon({Key? key, this.isAlreadyNotified})
      : super(key: key);

  final bool? isAlreadyNotified;

  CockpitController get _cockpitController => Get.find<CockpitController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreditCardController());
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (!sizingInfo.isNativeMobile) {
          return AdaptiveScaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: sizingInfo.isDesktop ? 220 : 32,
                      top: 64.h,
                      bottom: 49.h),
                  child: Text(
                    "Credit Card",
                    style: headlineBold26Secondary(
                      color: GlorifiColors.darkBlueColor,
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop ? 200.w : 0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1024),
                      child: AdaptiveGridItem(
                        nativeMobile: 100,
                        webMobile: 100,
                        desktop: 100,
                        tablet: 100,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                GlorifiAssets.creditCardComingSoonWeb,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    GlorifiColors.darkMidnightBlue
                                        .withOpacity(0.0),
                                    GlorifiColors.darkMidnightBlue
                                        .withOpacity(0.5),
                                    GlorifiColors.darkMidnightBlue
                                        .withOpacity(0.8),
                                    GlorifiColors.darkMidnightBlue,
                                    GlorifiColors.darkMidnightBlue,
                                  ],
                                  stops: [0.0, 0.3, 0.5, 0.6, 1.0],
                                ),
                              ),
                            ),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              bottom: -1,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 48.w, right: 24.w, bottom: 51.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comingSoon(),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      "A Credit Card That Works As\nHard As You Do.",
                                      style: headlineRegular26Secondary(
                                        color: GlorifiColors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(
                                      "Rewards, security, and convenience are yours with the Brass card. Be\nthe first to know when it’s available.",
                                      style: smallRegular16Primary(
                                        color: GlorifiColors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70.h,
                                    ),
                                    Container(
                                      width: !sizingInfo.isWebMobile
                                          ? 342.w
                                          : MediaQuery.of(context).size.width,
                                      child: notifyButton(
                                        controller,
                                        isAlreadyNotified,
                                        context,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return AdaptiveScaffoldNative().getScaffold(
            context: context,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        GlorifiColors.darkMidnightBlue,
                        GlorifiColors.gradientDarkBlue
                      ],
                      center: Alignment(0.9, -0.3),
                      focal: Alignment(0.3, -0.1),
                      focalRadius: 1.0,
                    ),
                  ),
                ),
                Container(
                    width: 1.sw,
                    child: Image.asset(
                      sizingInfo.isNativeMobile
                          ? GlorifiAssets.creditCardComingSoon
                          : GlorifiAssets.creditCardComingSoonWeb,
                      fit: BoxFit.fill,
                    ).paddingOnly(
                        left: 34.w, top: 39.w, right: 44.w, bottom: 375.h)),
                Positioned(
                  width: 1.sw,
                  bottom: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 24.w, right: 24.w, bottom: 51.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        comingSoon(),
                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "Get up to 2% cash back with our Mastercard",
                              style: headlineRegular26Primary(
                                color: GlorifiColors.white,
                              ),
                            ),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: Offset(2, -6),
                                child: Text(
                                  '® ',
                                  //superscript is usually smaller in size
                                  textScaleFactor: 0.7,
                                  style: headlineRegular21Primary(
                                    color: GlorifiColors.white,
                                  ),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: ' credit cards.',
                              style: headlineRegular26Primary(
                                color: GlorifiColors.white,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Support the America you love, give back, and enjoy all of the rewards. Be the first to know when they’re available.",
                          style: smallRegular16Primary(
                            color: GlorifiColors.white,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        notifyButton(controller, isAlreadyNotified, context),
                      ],
                    ),
                  ),
                ),
                getOverlayWidget(isAlreadyNotified, _cockpitController),
              ],
            ),
          );
        }
      },
    );
  }
}

Widget getOverlayWidget(
    bool? isAlreadyNotified, CockpitController cockpitController) {
  return InkWell(
    child: SvgPicture.asset(GlorifiAssets.caret_2).paddingOnly(
      top: 70.h,
    ),
    onTap: () {
      if (isAlreadyNotified != null && isAlreadyNotified == true) {
        Get.offNamedUntil(Routes.cockpit, (route) => true);
      } else {
        Get.back();
      }
    },
  ).paddingOnly(
    left: 24.w,
  );
}

Widget comingSoon() {
  return Text(
    "Get Early Access",
    style: bodyRegular18Primary(
      color: GlorifiColors.selectedIndicatorColor,
    ),
  );
}

Widget notifyButton(CreditCardController controller, bool? isAlreadyNotified,
    BuildContext context) {
  return isAlreadyNotified != null && isAlreadyNotified == true
      ? Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            color: GlorifiColors.greenTint[50],
          ),
          child: Text(
            "You’re on the wait list",
            textAlign: TextAlign.center,
            style: bodyBold18Primary(
              color: GlorifiColors.gradientLightGreen,
            ),
          ).paddingSymmetric(vertical: 15.h),
        )
      : PrimaryDarkButton(
          title: "Check to see if available ",
          width: MediaQuery.of(context).size.width,
          height: 56,
          textColor: GlorifiColors.blueMidnightBlue,
          icon: SvgPicture.asset(
            GlorifiAssets.rightArrow,
            color: GlorifiColors.primaryButtonIconColor,
          ),
          primaryColor: GlorifiColors.white,
          onTap: () => Get.to(
            MortgagePreApplyScreen(
              isFromCreditCard: true,
            ),
          ),
        );
}
