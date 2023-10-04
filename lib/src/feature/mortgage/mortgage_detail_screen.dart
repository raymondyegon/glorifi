import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/widgets/mortgage_detail_tile.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../utils/glorifi_assets.dart';
import '../../utils/glorifi_colors.dart';
import '../../widgets/buttons/app_button.dart';
import '../policy_detail/widget/policy_text_style.dart';
import 'controllers/mortgage_detail_controller.dart';

class MortgageDetailScreen extends StatelessWidget {
  const MortgageDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MortgageDetailController>();

    AdaptiveGridItem glorifiAccounts() {
      return AdaptiveGridItem(
        desktop: 60,
        tablet: 100,
        nativeMobile: 100,
        webMobile: 100,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 16.r, right: 42.r, top: 16.r, bottom: 16.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Application Number",
                                  style: captionBold14Secondary(
                                    color: GlorifiColors.creditBgGrey,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  controller.data.referenceNumber,
                                  style: captionSemiBold14Primary(
                                    color: GlorifiColors.biscayBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Application Status",
                                  style: captionBold14Secondary(
                                    color: GlorifiColors.creditBgGrey,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  controller.data.status == "Application in Progress"
                                      ? "In Progress"
                                      : "Submitted",
                                  style: captionSemiBold14Primary(
                                    color: GlorifiColors.biscayBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                MortgageDetailTile(
                  firstHeading: "Date Started",
                  firstData:
                      controller.dateFormatter(controller.data.createdDate),
                ),
                SizedBox(
                  height: 24.h,
                ),
                TextButton(
                  onPressed: () => {
                    controller.navigateToBlend(),
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: GlorifiColors.cornflowerBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0.h),
                      child: Text(
                        "Continue Application",
                        style: bodyBold18Primary(
                          color: GlorifiColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (!sizingInfo.isNativeMobile) {
          return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.bgColor,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 64.h,
                          ),
                          Text(
                            "Mortgage Loan",
                            style: headlineRegular31Secondary(
                              color: GlorifiColors.biscayBlue,
                            ),
                          ),
                          AdaptiveGrid(
                            children: [
                              glorifiAccounts(),
                              AdaptiveGridItem(
                                desktop: 40,
                                webMobile: 100,
                                tablet: 100,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizingInfo.isDesktop ? 32.w : 0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(16.r),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Support",
                                                textAlign: TextAlign.start,
                                                style: PolicyTextStyle
                                                    .textStylePolicy,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Divider(
                                                height: 1.h,
                                                color: GlorifiColors
                                                    .cornflowerBlue,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Text(
                                                "Agent Name",
                                                style: smallBold16Primary(
                                                  color:
                                                      GlorifiColors.biscayBlue,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      GlorifiAssets.phonePhone,
                                                      color: GlorifiColors
                                                          .biscayBlue,
                                                    ),
                                                    SizedBox(
                                                      width: 9.w,
                                                    ),
                                                    Text(
                                                      TextConstants.contact_number_mortgage,
                                                      style:
                                                          smallSemiBold16Primary(
                                                        color: GlorifiColors
                                                            .biscayBlue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {controller.makePhoneCall('tel: ${TextConstants.contact_number_mortgage}');},
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  TextConstants.mortgage_support_email,
                                                  style: smallSemiBold16Primary(
                                                    color:
                                                        GlorifiColors.biscayBlue,
                                                  ),
                                                ),
                                                onTap: controller.launchEmail,
                                              ),
                                              SizedBox(
                                                height: 28.h,
                                              ),
                                              TextButton(
                                                onPressed: () => {
                                                  controller.navigateToFAQ(),
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      GlorifiColors.white,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.r,
                                                    ),
                                                    side: BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: 1,
                                                      color: GlorifiColors
                                                          .selectedIndicatorColor,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0.h),
                                                    child: Text(
                                                      "Mortgage FAQs",
                                                      style:
                                                          smallRegular16Primary(
                                                        color: GlorifiColors
                                                            .biscayBlue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
            backgroundColor: GlorifiColors.bgColor,
            glorifiAppBar: GlorifiAppBar(
              title: 'Application Details',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mortgage Loan",
                      style: headlineRegular31Secondary(
                        color: GlorifiColors.biscayBlue,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    MortgageDetailTile(
                      firstHeading: "Application Number",
                      firstData: controller.data.referenceNumber,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    MortgageDetailTile(
                      firstHeading: "Application Status",
                      firstData:
                          controller.data.status == "Application in Progress"
                              ? "In Progress"
                              : "Submitted",
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    MortgageDetailTile(
                      firstHeading: "Date Started",
                      firstData:
                          controller.dateFormatter(controller.data.createdDate),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    AppButton(
                      height: 50.h,
                      backgroundColor: GlorifiColors.cornflowerBlue,
                      borderColor: GlorifiColors.cornflowerBlue,
                      fontSize: 18.sp,
                      textColor: GlorifiColors.white,
                      label: "Continue Application",
                      textStyle: bodyBold18Primary(
                        color: GlorifiColors.white,
                      ),
                      onTap: () {
                        controller.navigateToBlend();
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Support",
                              textAlign: TextAlign.start,
                              style: PolicyTextStyle.textStylePolicy,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Divider(
                              height: 1.h,
                              color: GlorifiColors.cornflowerBlue,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text(
                              "Agent Name",
                              style: smallBold16Primary(
                                color: GlorifiColors.biscayBlue,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  GlorifiAssets.phonePhone,
                                  color: GlorifiColors.biscayBlue,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller
                                        .makePhoneCall('tel:${TextConstants.contact_number_mortgage}');
                                  },
                                  child: Text(TextConstants.contact_number_mortgage,
                                      style: smallSemiBold16Primary(
                                        color: GlorifiColors.biscayBlue,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                              onTap: controller.launchEmail,
                              child: Text(TextConstants.mortgage_support_email,
                                  style: smallSemiBold16Primary(
                                    color: GlorifiColors.biscayBlue,
                                  )),
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            AppButton(
                              elevation: 0,
                              height: 50.h,
                              backgroundColor: GlorifiColors.white,
                              borderColor: GlorifiColors.selectedIndicatorColor,
                              fontSize: 18.sp,
                              label: "Mortgage FAQs",
                              textStyle: smallRegular16PrimaryBold(
                                color: GlorifiColors.midnightBlue,
                              ),
                              onTap: () {
                                controller.navigateToFAQ();
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        left: 5.w,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        TextConstants.legalName,
                        maxLines: 2,
                        style: smallRegular8(
                            color: GlorifiColors.midnightBlueColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
