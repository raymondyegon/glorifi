import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';
import '../../routes/app_pages.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../utils/glorifi_assets.dart';
import '../../utils/glorifi_colors.dart';
import '../../widgets/buttons/primary_buton_dark.dart';
import 'controller/credit_card_controller.dart';

class CreditCardUnavailable extends StatelessWidget {
  CreditCardUnavailable({Key? key}) : super(key: key);

  final data = Get.arguments;
  late final bool stateAvailability = data[0]['stateAvailability'];
  late final String stateName = data[0]['stateName'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreditCardController>();
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
                                GlorifiAssets.brokerageBgWeb,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    GlorifiColors.midnightBlue.withOpacity(0.0),
                                    GlorifiColors.midnightBlue.withOpacity(0.5),
                                    GlorifiColors.midnightBlue.withOpacity(0.8),
                                    GlorifiColors.midnightBlue,
                                    GlorifiColors.midnightBlue,
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
                                    Text(
                                      stateAvailability
                                          ? "We don’t currently offer credit cards for your state."
                                          : "Sorry, we don’t offer credit cards in your state.",
                                      style: headlineRegular26Secondary(
                                        color: GlorifiColors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(
                                      stateAvailability
                                          ? "We’ll notify you by email as soon as our exclusive GloriFi Mastercards® and World Elite Mastercard® cards are available in your area."
                                          : "We’ll notify you by email if our GloriFi Mastercards® and World Elite Mastercard® cards become available in your area.",
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
                                      child: stateAvailability
                                          ? notifyButton(
                                              controller, context, stateName)
                                          : viewProductsButton(context),
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
            body: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1024),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            stateAvailability
                                ? GlorifiAssets.creditCardUnavailableBackground
                                : GlorifiAssets
                                    .creditCardPermanentlyUnavailableBackground,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: GlorifiColors.midnightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          GlorifiColors.midnightBlue.withOpacity(0.0),
                          GlorifiColors.midnightBlue.withOpacity(0.5),
                          GlorifiColors.midnightBlue.withOpacity(0.8),
                          GlorifiColors.midnightBlue,
                          GlorifiColors.midnightBlue,
                        ],
                        stops: [0.0, 0.3, 0.5, 0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 24.w, right: 24.w, bottom: 51.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stateAvailability
                                ? "We don’t currently offer credit cards for your state."
                                : "Sorry, we don’t offer credit cards in your state.",
                            style: headlineRegular26Secondary(
                              color: GlorifiColors.white,
                            ).copyWith(
                              height: !sizingInfo.isTablet ? 1.5.h : 0,
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            stateAvailability
                                ? "We’ll notify you by email as soon as our exclusive GloriFi Mastercards® and World Elite Mastercard® cards are available in your area."
                                : "We’ll notify you by email if our GloriFi Mastercards® and World Elite Mastercard® cards become available in your area.",
                            style: smallRegular16Primary(
                              color: GlorifiColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          stateAvailability
                              ? notifyButton(controller, context, stateName)
                              : viewProductsButton(context),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          height: 25.h,
                          width: 25.w,
                          child: SvgPicture.asset(GlorifiAssets.caret_2),
                        ),
                        onTap: Get.back,
                      ),
                      Text(
                        "Credit Card",
                        style: headlineRegular21Secondary(
                          color: GlorifiColors.blueMidnightBlue,
                        ),
                      ).paddingOnly(
                        left: 32.w,
                      ),
                    ],
                  ).paddingOnly(
                    left: 24.w,
                    top: 60.h,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

Widget comingSoon() {
  return Text(
    "Coming Soon",
    style: bodyRegular18Secondary(
      color: GlorifiColors.selectedIndicatorColor,
    ),
  );
}

Widget notifyButton(
    CreditCardController controller, BuildContext context, String stateName) {
  return Obx(
    () => PrimaryDarkButton(
      title: "Notify Me By Email",
      width: MediaQuery.of(context).size.width,
      height: 56,
      progressBarColor: GlorifiColors.midnightBlue,
      textColor: GlorifiColors.blueMidnightBlue,
      icon: SvgPicture.asset(
        GlorifiAssets.rightArrow,
        color: GlorifiColors.primaryButtonIconColor,
      ),
      primaryColor: GlorifiColors.white,
      isLoading: controller.isLoading.value,
      onTap: () => controller.notifyEmailStatus("Credit Card", stateName),
    ),
  );
}

Widget viewProductsButton(BuildContext context) {
  return PrimaryDarkButton(
    title: "View Other Products ",
    width: MediaQuery.of(context).size.width,
    height: 56,
    textColor: GlorifiColors.blueMidnightBlue,
    icon: SvgPicture.asset(
      GlorifiAssets.rightArrow,
      color: GlorifiColors.primaryButtonIconColor,
    ),
    primaryColor: GlorifiColors.white,
    onTap: () {
      Get.offNamedUntil(Routes.cockpit, (route) => true);
    },
  );
}
