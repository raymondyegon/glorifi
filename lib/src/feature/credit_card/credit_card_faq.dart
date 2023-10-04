import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card/controller/credit_card_faq_controller.dart';
import 'package:glorifi/src/feature/credit_card/widgets/apply_button.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../font_style_global.dart';

class CreditCardFAQ extends StatelessWidget {
  const CreditCardFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreditCardFAQController>();

    AdaptiveGridItem banner(final sizingInfo) {
      return AdaptiveGridItem(
        desktop: 100,
        webMobile: 100,
        tablet: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: sizingInfo.isDesktop ? 630.h : 510.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: sizingInfo.isDesktop ? 630.h : 510.h,
                    child: Image.asset(
                      controller.getBannerAsset(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 350.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xFF03213D).withOpacity(0.2),
                          Color(0xFF03213D).withOpacity(0.4),
                          Color(0xFF03213D).withOpacity(0.9),
                          Color(0xFF03213D),
                          Color(0xFF103213D),
                        ],
                        stops: [0.0, 0.4, 0.6, 0.75, 0.8, 1],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.w, vertical: 64.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Card looks great with your name on it",
                        style: headlineRegular48Secondary(
                          color: GlorifiColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "GloriFi Bras Card",
                        style: headlineBold21Secondary(
                          color: GlorifiColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "Opening an account is easy. Just a few personal details, your social security number, a form of identification –",
                        style: bodyRegular18Primary(
                          color: GlorifiColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "APPLY NOW",
                            style: bodyBold18Primary(
                              color: GlorifiColors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            GlorifiAssets.arrowForward,
                            color: GlorifiColors.bloodOrange,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget mainWidget = Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                controller.getBannerAsset(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 350.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFF212C37).withOpacity(0.4),
                    Color(0xFF1F3B73).withOpacity(0.9),
                    Color(0xFF1F3B73),
                    Color(0xFF1F3B73),
                  ],
                  stops: [0.0, 0.6, 0.75, 0.8, 1],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 26.0.w, vertical: 5.h),
                    child: Obx(
                      () => Text(
                        controller.details.value.title,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 28,
                            height: 1.4,
                            fontFamily: 'univers',
                            fontWeight: FontWeight.w400,
                            color: GlorifiColors.basicLightGrey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 150.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              Obx(
                () => Text(
                  controller.details.value.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.4,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w400,
                      color: GlorifiColors.cornflowerBlue),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              ApplyButton(
                title: "Apply Now",
                onTap: controller.navigateToBlend,
                showIcon: true,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ],
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isNativeMobile) {
        return AdaptiveScaffoldNative().getScaffold(
          context: context,
          glorifiAppBar: GlorifiAppBar(
            title: "Brass Card",
          ),
          backgroundColor: GlorifiColors.productsBgWhite,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                mainWidget,
                Positioned(top: 230, child: controller.cardWidget())
              ],
            ),
          ),
        );
      } else {
        return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  PageHeader(
                      headerTitle: "Credit Card",
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizingInfo.isDesktop
                            ? 200.w
                            : sizingInfo.isTablet
                                ? 34.5.w
                                : 24.5.w,
                        vertical: 25.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1024),
                      child: AdaptiveGrid(
                        children: [
                          banner(sizingInfo),
                          AdaptiveGridItem(
                            webMobile: 100,
                            desktop: 50,
                            tablet: 100,
                            child: Image.asset(
                              controller.getCardAsset(),
                              fit: BoxFit.fill,
                              width: sizingInfo.isDesktop ? 496.w : 740.w,
                              height: sizingInfo.isDesktop ? 313.h : 450.h,
                            ).paddingOnly(
                                top: 33.h,
                                right: sizingInfo.isDesktop ? 0 : 24.h),
                          ),
                          AdaptiveGridItem(
                            webMobile: 100,
                            desktop: 50,
                            tablet: 100,
                            child: Column(
                              children: [
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut dictum turpis. Maecenas commodo, lacus vel fermentum lobortis, erat sem sagittis tellus, at laoreet metus urna id ante. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut dictum turpis. Maecenas commodo, lacus vel fermentum lobortis, erat sem sagittis tellus, at laoreet metus urna id ante. ',
                                  style: bodyRegular18Primary(
                                    color: GlorifiColors.cornflowerBlue,
                                  ),
                                ),
                                SizedBox(
                                  height: 47.h,
                                ),
                                ApplyButton(
                                  title: "Apply Now",
                                  onTap: controller.navigateToBlend,
                                  showIcon: true,
                                )
                              ],
                            ).paddingOnly(
                                left: 33.h,
                                top: 47.h,
                                right: sizingInfo.isDesktop ? 0 : 24.h),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }
    });
  }
}
