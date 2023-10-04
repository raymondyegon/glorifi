import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../utils/glorifi_assets.dart';
import '../../utils/glorifi_colors.dart';
import '../../utils/support/support_navigation_helper.dart';
import '../../widgets/buttons/app_button.dart';
import '../../widgets/buttons/primary_buton_dark.dart';
import '../../widgets/containers/gradient_overlay_container.dart';
import '../credit_card/controller/credit_card_controller.dart';

class MortgageUnavailableScreen extends StatelessWidget {
  MortgageUnavailableScreen({Key? key}) : super(key: key);

  late final String stateName = Get.arguments[0]['stateName'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreditCardController());
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (!sizingInfo.isNativeMobile) {
          return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.productsBgWhite,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                GlorifiAssets.mortgageBgWeb,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GradientOverlayContainer(
                        stops: [0.2, 0.50, 1],
                        colors: [
                          GlorifiColors.defaultGradientStartColor,
                          GlorifiColors.midnightBg,
                          GlorifiColors.defaultGradientEndColor,
                        ],
                        child: Container(
                            height: Get.height + 10, width: Get.width),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: 240,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizingInfo.isDesktop
                                  ? 200.w
                                  : sizingInfo.isTablet
                                      ? 34.5.w
                                      : 24.5.w),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 1024),
                            child: AdaptiveGrid(
                              children: [
                                AdaptiveGridItem(
                                  desktop: 55,
                                  tablet: 100,
                                  nativeMobile: 100,
                                  webMobile: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      mortgageHeading(),
                                      SizedBox(
                                        height: 32.h,
                                      ),
                                      mortgageSubHeading(),
                                    ],
                                  ),
                                ),
                                AdaptiveGridItem(
                                  desktop: 45,
                                  webMobile: 100,
                                  tablet: 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizingInfo.isDesktop ? 32.w : 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 38.h,
                                        ),
                                        Obx(() => PrimaryDarkButton(
                                          title: TextConstants.notifyMeByEmail,
                                          width: MediaQuery.of(context).size.width,
                                          height: 56,
                                          isLoading: controller.isLoading.isTrue ? true : false,
                                          progressBarColor: GlorifiColors.midnightBlue,
                                          textColor: GlorifiColors.ebonyBlue,
                                          primaryColor: GlorifiColors.white,
                                          onTap: () {
                                            controller.notifyEmailStatus(TextConstants.mortgage,stateName);
                                          },
                                        ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        mortgageFaqButton(),
                                        SizedBox(
                                          height: 38.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return AdaptiveScaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: GlorifiColors.productsBgWhite,
            appBar: GlorifiAppBar(
              title: TextConstants.stateDoesNotApply,
              trailing: Trailing(
                  icon: SvgPicture.asset(
                    GlorifiAssets.close,
                    height: 24,
                    width: 24,
                  ),
                  onTap: () {
                    Get.back();
                  }),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        GlorifiAssets.mortgageBackground,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: constraints.maxHeight,
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizingInfo.isNativeMobile ? 24.h : 32.h,
                            vertical: sizingInfo.isNativeMobile ? 20.w : 40.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              mortgageHeading(),
                              SizedBox(
                                height: 24.h,
                              ),
                              mortgageSubHeading(),
                              SizedBox(
                                height: 38.h,
                              ),
                              Obx(
                                () => PrimaryDarkButton(
                                  title: TextConstants.notifyMeByEmail,
                                  width: MediaQuery.of(context).size.width,
                                  height: 56,
                                  isLoading: controller.isLoading.isTrue
                                      ? true
                                      : false,
                                  progressBarColor: GlorifiColors.midnightBlue,
                                  textColor: GlorifiColors.ebonyBlue,
                                  primaryColor: GlorifiColors.white,
                                  onTap: () {
                                    controller.notifyEmailStatus(TextConstants.mortgage,stateName);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              mortgageFaqButton(),
                              SizedBox(
                                height: 36.h,
                              ),
                              Text(
                                TextConstants.legalName,
                                maxLines: 2,
                                style:
                                    smallRegular8(color: GlorifiColors.white),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

Widget mortgageFaqButton() {
  return AppButton(
    height: 56,
    elevation: 0,
    backgroundColor: GlorifiColors.midnightBlue,
    borderColor: GlorifiColors.selectedIndicatorColor,
    fontSize: 16.sp,
    label: TextConstants.mortgageFAQs,
    textStyle: smallBold16Primary(
      color: GlorifiColors.selectedIndicatorColor,
    ),
    onTap: () {
      String category = 'Mortgage';
      SupportNavigationHelper.navigateToList(category);
    },
  );
}

Widget mortgageHeading() {
  return Text(
    //"We don’t currently have mortgage offerings for this state. ",
    "We don’t currently offer  mortgages for this state.",
    style: headlineRegular31Secondary(
      color: GlorifiColors.white,
    ),
  );
}

Widget mortgageSubHeading() {
  return Text(
    //"We are growing quickly and will have mortgages available for your state. Be the first to find out.",
    "We’re growing quickly and will have mortgages available soon. Get notified and be the first to find out when your state is available.",
    style: smallRegular16Primary(
      color: GlorifiColors.white,
    ),
  );
}
