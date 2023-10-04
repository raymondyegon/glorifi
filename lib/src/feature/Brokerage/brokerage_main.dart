import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/member_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/glorifi_assets.dart';
import '../../utils/glorifi_colors.dart';
import '../../widgets/appbars/glorifi_appbar.dart';
import '../../widgets/buttons/app_button.dart';
import '../credit_card/controller/credit_card_controller.dart';

class BrokerageMainPage extends GetView<MemberController> {
  BrokerageMainPage({Key? key}) : super(key: key);

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
                    "Investments",
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
                                    comingSoon(),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      "Investing is about to get way\neasier.",
                                      style: headlineRegular26Secondary(
                                        color: GlorifiColors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Text(
                                      "Financial freedom means having options that support your values.\nGloriFi will soon offer the ability to trade ETFs, stocks and more. Be the\nfirst to know when it’s available.",
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
                                      child: notifyButton(controller),
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
            glorifiAppBar: GlorifiAppBar(
              title: "Investments",
            ),
            body: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1024),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  GlorifiAssets.brokerageBg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
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
                          comingSoon(),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "Investing is about to get way easier.",
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
                            "Financial freedom means having options that support your values. GloriFi will soon offer the ability to trade ETFs, stocks and more. Be the first to know when it’s available.",
                            style: smallRegular16Primary(
                              color: GlorifiColors.white,
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          notifyButton(controller)
                        ],
                      ),
                    ),
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

Widget notifyButton(CreditCardController controller) {
  return AppButton(
      height: 56,
      elevation: 0,
      backgroundColor: GlorifiColors.white,
      borderColor: GlorifiColors.white,
      fontSize: 16.sp,
      label: "Notify Me by Email",
      textStyle: bodyBold18Primary(
        color: GlorifiColors.midnightBlueColor,
      ),
      onTap: () => controller.sendNotify("Investment", ""));
}
