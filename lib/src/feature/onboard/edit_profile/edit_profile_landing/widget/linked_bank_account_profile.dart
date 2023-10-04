import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import '../../../../../utils/glorifi_assets.dart';

class LinkedBankProfile extends StatelessWidget {
  const LinkedBankProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget commonAdaptiveGrid(
        {required List<AdaptiveGridItem> children,
        required AdaptiveSizingInfo sizingInfo}) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sizingInfo.isNativeMobile)
              PageHeader(
                  headerTitle: "Linked Bank Accounts",
                  showTrailingButton: false,
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
                  vertical: 50.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: AdaptiveGrid(
                  children: children,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return AdaptiveBuilder(
      builder: (BuildContext context, AdaptiveSizingInfo sizingInformation) {
        return AdaptiveBuilder(
          builder: (context, sizingInfo) {
            if (sizingInfo.isDesktop) {
              return AdaptiveScaffoldWeb().getScaffold(
                  context: context,
                  backgroundColor: GlorifiColors.productsBgWhite,
                  body: commonAdaptiveGrid(sizingInfo: sizingInfo, children: [
                    AdaptiveGridItem(
                      desktop: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Link Accounts",
                            style: headlineSemiBold26Primary(
                                color: GlorifiColors.cornflowerBlue),
                          ).paddingSymmetric(vertical: 30.h, horizontal: 10.w),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0.h, horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "External Accounts",
                                    style: smallSemiBold16Primary(
                                      color: GlorifiColors.cornflowerBlue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ADD",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.cornflowerBlue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SvgPicture.asset(
                                        GlorifiAssets.gridAddIcon,
                                        width: 22.w,
                                        height: 22.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 32.w),
                    ),
                    AdaptiveGridItem(
                      desktop: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connected Accounts",
                            style: headlineSemiBold26Primary(
                                color: GlorifiColors.cornflowerBlue),
                          ).paddingSymmetric(vertical: 30.h, horizontal: 10.w),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 25.0.h, horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Costco Anywhere Visa",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.cornflowerBlue,
                                        ),
                                      ),
                                      Text(
                                        "***1234 | Citibank Online",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.cornflowerBlue,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                     "Unlink",
                                     style: headlineBold21Primary(
                                       color: GlorifiColors.cornflowerBlue,
                                     ),
                                   ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ).paddingSymmetric(horizontal: 32.w),
                    )
                  ]));
            } else if (sizingInfo.isTablet) {
              return AdaptiveScaffoldWeb().getScaffold(
                context: context,
                backgroundColor: GlorifiColors.productsBgWhite,
                body: commonAdaptiveGrid(children: [
                  AdaptiveGridItem(
                    tablet: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Link Accounts",
                          style: headlineSemiBold26Primary(
                              color: GlorifiColors.cornflowerBlue),
                        ).paddingSymmetric(vertical: 30.h, horizontal: 10.w),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0.h, horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "External Accounts",
                                  style: smallSemiBold16Primary(
                                    color: GlorifiColors.cornflowerBlue,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ADD",
                                      style: smallSemiBold16Primary(
                                        color: GlorifiColors.cornflowerBlue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SvgPicture.asset(
                                      GlorifiAssets.gridAddIcon,
                                      width: 22.w,
                                      height: 22.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ).paddingOnly(right: 11.w),
                  ),
                  AdaptiveGridItem(
                    tablet: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connected Accounts",
                          style: headlineSemiBold26Primary(
                              color: GlorifiColors.cornflowerBlue),
                        ).paddingSymmetric(vertical: 30.h, horizontal: 10.w),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0.h, horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Costco Anywhere Visa",
                                      style: smallSemiBold16Primary(
                                        color: GlorifiColors.cornflowerBlue,
                                      ),
                                    ),
                                    Text(
                                      "***1234 | Citibank Online",
                                      style: smallSemiBold16Primary(
                                        color: GlorifiColors.cornflowerBlue,
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  "Unlink",
                                  style: headlineBold21Primary(
                                    color: GlorifiColors.cornflowerBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ], sizingInfo: sizingInfo),
              );
            } else {
              return AdaptiveScaffold(
                backgroundColor: GlorifiColors.productsBgWhite,
                appBar: GlorifiAppBar(
                  title: "Linked Bank Accounts",
                ),
                body: commonAdaptiveGrid(children: [
                  AdaptiveGridItem(
                      webMobile: 100,
                      nativeMobile: 100,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Connected Accounts",
                            style: captionBold14Primary(
                                color: GlorifiColors.cornflowerBlue),
                          ).paddingSymmetric(vertical: 20.h,),




                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0.h, horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Costco Anywhere Visa",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.cornflowerBlue,
                                        ),
                                      ),
                                      Text(
                                        "***1234 | Citibank Online",
                                        style: smallSemiBold16Primary(
                                          color: GlorifiColors.cornflowerBlue,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "Unlink",
                                    style: headlineBold21Primary(
                                      color: GlorifiColors.cornflowerBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical:5),
                            padding:EdgeInsets.all(10) ,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [


                                Text(
                                  "External Accounts",
                                  style: bodyBold18Primary(
                                    color: GlorifiColors.cornflowerBlue,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ADD",
                                      style: smallSemiBold16Primary(
                                        color: GlorifiColors.cornflowerBlue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SvgPicture.asset(
                                      GlorifiAssets.gridAddIcon,
                                      width: 22.w,
                                      height: 22.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 15.w)),
                ], sizingInfo: sizingInfo),
              );
            }
          },
        );
      },
    );
  }
}
