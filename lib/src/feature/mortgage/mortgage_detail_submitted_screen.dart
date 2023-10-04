import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../utils/constants.dart';
import '../../utils/glorifi_colors.dart';
import '../../utils/support/support_navigation_helper.dart';
import '../../widgets/appbars/glorifi_appbar.dart';
import '../../widgets/buttons/app_button.dart';
import 'controllers/mortgage_detail_controller.dart';

class MortgageDetailSubmittedScreen extends StatelessWidget {
  const MortgageDetailSubmittedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _glorifiAccounts = AdaptiveGridItem(
      desktop: 55,
      tablet: 100,
      nativeMobile: 100,
      webMobile: 100,
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Column(
            children: [
              SvgPicture.asset(GlorifiAssets.mortgageBg),
              SizedBox(
                height: 48.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Congratulations you have submitted your loan application.",
                  style: headlineRegular31Secondary(
                    color: GlorifiColors.white,
                  ).copyWith(height: 1.5),
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your loan officer will now be in touch with you via email and phone.",
                  textAlign: TextAlign.start,
                  style: smallRegular16Primary(
                    color: GlorifiColors.white,
                  ).copyWith(
                    height: 1.4.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (!sizingInfo.isNativeMobile) {
          return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.midnightBlue,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
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
                          _glorifiAccounts,
                          AdaptiveGridItem(
                            desktop: 40,
                            webMobile: 100,
                            tablet: 100,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizingInfo.isDesktop ? 32.w : 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 166.h),
                                  Text(
                                    "Support",
                                    textAlign: TextAlign.start,
                                    style: headlineRegular21Secondary(
                                      color: GlorifiColors.lightWhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: GlorifiColors.lightWhite,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    "Agent Name",
                                    style: smallBold16Primary(
                                      color: GlorifiColors.lightWhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        GlorifiAssets.phonePhone,
                                        color: GlorifiColors.lightWhite,
                                      ),
                                      SizedBox(
                                        width: 9.w,
                                      ),
                                      Text(
                                        "555 555-5555",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.lightWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    "agent-mlo@glorifi.com",
                                    style: smallSemiBold16Primary(
                                      color: GlorifiColors.lightWhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28.h,
                                  ),
                                  PrimaryButton(
                                    onTap: () => {
                                      SupportNavigationHelper.navigateToList(
                                        'Mortgage',
                                      ),
                                    },
                                    title: TextConstants.mortgageFAQs,
                                    height: 64.h,
                                    primaryColor: GlorifiColors.white,
                                    textColor: GlorifiColors.midnightBlueColor,
                                    splashColor: GlorifiColors.midnightBlueColor,
                                    fontSize: 18.sp,
                                  ),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  Text(
                                    TextConstants.legalName,
                                    maxLines: 2,
                                    style: smallRegular8(
                                        color: GlorifiColors.white),
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return AdaptiveScaffoldNative().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.midnightBlue,
            glorifiAppBar: GlorifiAppBar(
              title: '',
              bgColor: GlorifiColors.midnightBlue,
              leadingIconDefaultColor: Colors.white,
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(GlorifiAssets.mortgageBg),
                      ),
                      Text(
                        "Congratulations you have submitted your loan application.",
                        style: headlineRegular31Secondary(
                          color: GlorifiColors.white,
                        ).copyWith(
                          height: 1.4.h,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Your loan officer will now be in touch with you via email and phone.",
                        style: smallRegular16Primary(
                          color: GlorifiColors.white,
                        ).copyWith(
                          height: 1.4.h,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Support",
                            textAlign: TextAlign.start,
                            style: headlineRegular21Secondary(
                              color: GlorifiColors.lightWhite,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Divider(
                            height: 1.h,
                            color: GlorifiColors.lightWhite,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "Agent Name",
                            style: smallBold16Primary(
                              color: GlorifiColors.lightWhite,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                GlorifiAssets.phonePhone,
                                color: GlorifiColors.lightWhite,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              InkWell(
                                onTap: () {makePhoneCall('tel:$AgentSupportPhone');},
                                child: Text( AgentSupportPhone,
                                  style: smallSemiBold16Primary(
                                    color: GlorifiColors.lightWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          InkWell(
                            onTap: launchEmail,
                            child: Text( AgentSupportEmail,
                                style: smallSemiBold16Primary(
                                  color: GlorifiColors.lightWhite,
                                )),
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          PrimaryButton(
                            onTap: () {
                              String category = 'Mortgage';
                              SupportNavigationHelper.navigateToList(category);
                            },
                            title: TextConstants.mortgageFAQs,
                            height: 64.h,
                            primaryColor: GlorifiColors.white,
                            textColor: GlorifiColors.midnightBlueColor,
                            splashColor: GlorifiColors.midnightBlueColor,
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          TextConstants.legalName,
                          maxLines: 2,
                          style: smallRegular8(color: GlorifiColors.white),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void>  launchEmail() async {
    String email=AgentSupportEmail;
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
}
