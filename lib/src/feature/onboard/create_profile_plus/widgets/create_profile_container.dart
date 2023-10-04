import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_appbar.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

class CreateProfileContainer extends StatefulWidget {
  final double percent;
  final Widget child;
  final String title;
  final String progressBarActiveTitle;
  final String text;
  final bool hasPercentBar;
  final AdaptiveSizingInfo? sizingInfo;
  final List<String> pageTitles;

  CreateProfileContainer({
    Key? key,
    required this.percent,
    required this.child,
    required this.title,
    required this.text,
    this.progressBarActiveTitle = "",
    this.hasPercentBar = true,
    this.sizingInfo,
    this.pageTitles = const [],
  }) : super(key: key);

  @override
  CreateProfileContainerState createState() => CreateProfileContainerState();
}

class CreateProfileContainerState extends State<CreateProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: profileBackgroundColor,
        showSimpleAppBar: true,
        resizeToAvoidBottomInset: true,
        hideWebAppBar: sizingInfo.isWebMobile ? true : false,
        body: SafeArea(
          child: _pageContent().paddingOnly(top: 30.h, left: 30.w, right: 30.w),
        ),
      );
    });
  }

  Widget _pageContent() {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: AdaptiveGrid(
                  children: [
                    if (sizingInfo.isDesktop || sizingInfo.isTablet)
                      AdaptiveGridItem(
                          desktop: 100,
                          tablet: 100,
                          child: Padding(
                            padding: EdgeInsets.only(top: 65.h, bottom: 50.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Create Account",
                                  style: headlineRegular28Secondary(
                                    color: GlorifiColors.white,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.offAllNamed(Routes.login);
                                //   },
                                //   child: Icon(
                                //     Icons.clear,
                                //     size: 24,
                                //     color: GlorifiColors.white,
                                //   ),
                                // )
                              ],
                            ),
                          )),
                    AdaptiveGridItem(
                      desktop: 100,
                      tablet: 100,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: widget.hasPercentBar
                          ? ProfileAppBar(
                              titles: widget.pageTitles,
                              activeTitle: widget.progressBarActiveTitle,
                              onTap: () {
                                Get.back();
                              },
                              percent: widget.percent,
                            )
                          : Container(),
                    ),
                    if (sizingInfo.isDesktop || sizingInfo.isTablet)
                      AdaptiveGridItem(
                        desktop: 100,
                        tablet: 100,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 210.h, minHeight: 100.h),
                        ),
                      ),
                    AdaptiveGridItem(
                      desktop: 45,
                      tablet: 45,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: Column(
                        mainAxisAlignment: sizingInfo.isDesktop
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.title.trim().isNotEmpty
                              ? Text(
                                  widget.title,
                                  style: headlineRegular31Secondary(
                                      color: GlorifiColors.white),
                                ).paddingOnly(top: 30.h)
                              : Container(),
                          widget.text.trim().isNotEmpty
                              ? Text(
                                  widget.text,
                                  style: smallRegular16Primary(
                                      color: GlorifiColors.white),
                                ).paddingOnly(top: 20.h)
                              : Container(),
                        ],
                      ),
                    ),
                    if (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                      AdaptiveGridItem(
                        webMobile: 100,
                        nativeMobile: 100,
                        child: SizedBox(
                            height: widget.title.trim().isNotEmpty ||
                                    widget.text.trim().isNotEmpty
                                ? 8.h
                                : 0),
                      ),
                    if (sizingInfo.isDesktop || sizingInfo.isTablet)
                      AdaptiveGridItem(
                        desktop: 10,
                        tablet: 10,
                        child: SizedBox(),
                      ),
                    AdaptiveGridItem(
                      desktop: 45,
                      tablet: 45,
                      webMobile: 100,
                      nativeMobile: 100,
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
