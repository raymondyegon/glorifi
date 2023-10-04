import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_menu.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_breakpoints.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_screen_type.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/app_bar_web_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/support/support_navigation_helper.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

final String GLOBAL_APP_BAR_TAG = 'global_app_bar';

abstract class AdaptiveScaffoldImpl {
  PreferredSizeWidget? appBar(
      BuildContext context, AdaptiveSizingInfo sizingInfo) {}

  PreferredSizeWidget? simpleAppBar(
      BuildContext context, AdaptiveSizingInfo sizingInfo) {}

  Widget bottomNavBar(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget drawer(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget? endDrawer(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget getScaffold(
      {required BuildContext context,
      PreferredSizeWidget? glorifiAppBar,
      Color? backgroundColor,
      String? appBarTitle,
      required Widget body,
      Widget? bottomSheet,
      Widget? floatingActionButton,
      bool? resizeToAvoidBottomInset = true,
      bool isSimpleAppbar = false,
      bool isEndDrawerEnable = false}) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      final _appBar = appBar(context, sizingInfo);
      final _bottomNavBar = bottomNavBar(context, sizingInfo);
      final _drawer = drawer(context, sizingInfo);
      final _endDrawer =
          isEndDrawerEnable ? endDrawer(context, sizingInfo) : null;
      final mediaQuery = MediaQuery.of(context);
      return Scaffold(
        endDrawer: _endDrawer,
        appBar: getDeviceType(mediaQuery) == AdaptiveScreenType.nativeMobile
            ? glorifiAppBar
            : _appBar,
        body: body,
        bottomNavigationBar: _bottomNavBar,
        bottomSheet: bottomSheet,
        drawer: _drawer,
        backgroundColor: backgroundColor ?? Colors.white,
        floatingActionButton: floatingActionButton,
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );
    });
  }
}

class AdaptiveScaffold extends StatelessWidget {
  AdaptiveScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.appBarTitle,
    this.bottomSheet,
    this.floatingActionButton,
    this.hideWebAppBar = false,
    this.showSimpleAppBar = false,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  PreferredSizeWidget? appBar;
  Color? backgroundColor;
  String? appBarTitle;
  Widget body;
  Widget? bottomSheet;
  Widget? floatingActionButton;
  bool hideWebAppBar;
  bool showSimpleAppBar;
  bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.deviceType == AdaptiveScreenType.nativeMobile) {
        return AdaptiveScaffoldNative().getScaffold(
          context: context,
          glorifiAppBar: appBar,
          body: body,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor ?? Colors.white,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        );
      } else {
        return AdaptiveScaffoldWeb(
                hideWebAppBar: hideWebAppBar,
                showSimpleAppBar: showSimpleAppBar)
            .getScaffold(
          context: context,
          glorifiAppBar: appBar,
          body: body,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor ?? Colors.white,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          isEndDrawerEnable: true,
        );
      }
    });
  }
}

class AdaptiveScaffoldWeb extends AdaptiveScaffoldImpl {
  AdaptiveScaffoldWeb({
    Key? key,
    this.hideWebAppBar = false,
    this.showSimpleAppBar = false,
  });

  bool hideWebAppBar;
  bool showSimpleAppBar;

  @override
  PreferredSizeWidget? appBar(
      BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return !hideWebAppBar
        ? !showSimpleAppBar
            ? AdaptiveAppBar(
                hideWebAppBar: hideWebAppBar,
              )
            : _AdaptiveSimpleAppBar()
        : null;
  }

  @override
  Widget bottomNavBar(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return SizedBox();
  }

  @override
  Widget drawer(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return _AdaptiveDrawer();
  }

  @override
  Widget? endDrawer(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return _AdaptiveEndDrawer();
  }
}

class AdaptiveScaffoldNative extends AdaptiveScaffoldImpl {
  AdaptiveScaffoldNative({
    Key? key,
  });

  @override
  Widget bottomNavBar(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return SizedBox();
  }

  @override
  Widget drawer(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return _AdaptiveDrawer();
  }

  @override
  Widget? endDrawer(BuildContext context, AdaptiveSizingInfo sizingInfo) {
    return _AdaptiveEndDrawer();
  }
}

class AdaptiveAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AdaptiveAppBar({
    Key? key,
    this.hideWebAppBar = false,
  }) : super(key: key);

  final bool hideWebAppBar;

  @override
  State<AdaptiveAppBar> createState() => _AdaptiveAppBarState();

  @override
  Size get preferredSize => Size(1.sw, 56.h);
}

class _AdaptiveAppBarState extends State<AdaptiveAppBar> {
  GlobalAppBarWebController get appBarWebController =>
      Get.find<GlobalAppBarWebController>();

  String _getTwoLetterOfName(String firstName, String lastName) =>
      "${firstName.isNotEmpty ? firstName[0] : ''} "
      "${lastName.isNotEmpty ? lastName[0] : ''}";

  @override
  Widget build(BuildContext context) {
    Widget _glorifiTextLogo = SvgPicture.asset(
      GlorifiAssets.simpleLogo2,
      height: 26.h,
      width: 170.w,
    );

    Widget _menuIcon = GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Icon(
        Icons.menu,
        color: GlorifiColors.darkBlue,
        size: 24.sp,
      ),
    );

    Widget _supportIcon = GestureDetector(
      onTap: () => {
        SupportNavigationHelper.loadBottomSheet(),
      },
      child: Icon(
        Icons.messenger_outline,
        color: Colors.white,
        size: 27.5.sp,
      ),
    );

    Widget _getTwoLetterView() {
      return Obx(
        () => Container(
          height: 32.sp,
          width: 32.sp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: GlorifiColors.white.withOpacity(0.42),
            shape: BoxShape.circle,
            border: Border.all(color: GlorifiColors.darkBlueColor, width: 2.0),
          ),
          child: Text(
              _getTwoLetterOfName(
                appBarWebController.profileController.userProfile.firstName,
                appBarWebController.profileController.userProfile.lastName,
              ),
              textAlign: TextAlign.center,
              style: captionSemiBold14Primary(
                color: GlorifiColors.darkBlue,
              )),
        ),
      );
    }

    Widget _profileIcon = GestureDetector(
      onTap: () => Scaffold.of(context).openEndDrawer(),
      child: Obx(
        () => appBarWebController.profileController.profileImageString
                .trim()
                .isEmpty
            ? _getTwoLetterView()
            : SizedBox(
                height: 32.sp,
                width: 32.sp,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.memory(
                    base64Decode(appBarWebController
                        .profileController.profileImageString),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (widget.hideWebAppBar) {
          return Hero(
            tag: GLOBAL_APP_BAR_TAG,
            child: SizedBox.shrink(),
          );
        } else if (sizingInfo.deviceType == AdaptiveScreenType.desktop) {
          return Hero(
            tag: GLOBAL_APP_BAR_TAG,
            child: Material(
              type: MaterialType.canvas,
              child: Container(
                height: sizingInfo.screenSize.height,
                color: GlorifiColors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _glorifiTextLogo,
                    Container(
                      width: 762.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed(Routes.cockpit),
                            child: _HeaderTitleWidget(
                              title: 'Today',
                              imageAssets: GlorifiAssets.buildingCastle,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.snapshot),
                            child: _HeaderTitleWidget(
                              title: 'Snapshot',
                              imageAssets: GlorifiAssets.creditCard,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.accounts),
                            child: _HeaderTitleWidget(
                              title: 'Accounts',
                              imageAssets: GlorifiAssets.shield,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.reward),
                            child: _HeaderTitleWidget(
                              title: 'Rewards',
                              imageAssets: GlorifiAssets.home,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(
                              Routes.faqCategoriesListingScreen,
                            ),
                            child: _HeaderTitleWidget(
                              title: 'Support',
                              imageAssets: GlorifiAssets.arrowup,
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(Routes.exploreProducts),
                            child: _HeaderTitleWidget(
                              title: 'Explore',
                              imageAssets: GlorifiAssets.chatBubble,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _supportIcon,
                        SizedBox(width: 24.w),
                        _profileIcon,
                        SizedBox(width: 8.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                  "${appBarWebController.loyaltyController.currentTier} Member",
                                  textScaleFactor: 1,
                                  style: captionRegular14Primary(
                                    color: GlorifiColors.darkBlueColor,
                                  )),
                            ),
                            Obx(() => Text(
                                "${appBarWebController.loyaltyController.currentBalanceString} points",
                                textScaleFactor: 1,
                                style: captionSemiBold14Primary(
                                  color: GlorifiColors.darkBlueColor,
                                )))
                          ],
                        ),
                        SizedBox(width: 20.w),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (sizingInfo.deviceType == AdaptiveScreenType.tablet) {
          return Hero(
            tag: GLOBAL_APP_BAR_TAG,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              height: sizingInfo.screenSize.height,
              color: GlorifiColors.white,
              child: Row(
                children: [
                  _menuIcon,
                  const Spacer(),
                  _glorifiTextLogo,
                  const Spacer(),
                  _profileIcon,
                ],
              ),
            ),
          );
        } else {
          return Hero(
            tag: GLOBAL_APP_BAR_TAG,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              height: sizingInfo.screenSize.height,
              color: GlorifiColors.white,
              child: Row(
                children: [
                  _menuIcon,
                  const Spacer(),
                  _glorifiTextLogo,
                  const Spacer(),
                  _profileIcon,
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _AdaptiveSimpleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _AdaptiveSimpleAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _glorifiTextLogo = SvgPicture.asset(
      GlorifiAssets.simpleLogo2,
      height: 26.h,
      width: 170.w,
    );

    Widget _menuIcon = GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Icon(
        Icons.menu,
        color: GlorifiColors.darkBlue,
        size: 24.sp,
      ),
    );
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.deviceType == AdaptiveScreenType.desktop) {
        return Hero(
          tag: GLOBAL_APP_BAR_TAG,
          child: Container(
            height: sizingInfo.screenSize.height,
            color: GlorifiColors.white,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _glorifiTextLogo,
              ],
            ),
          ),
        );
      } else if (sizingInfo.deviceType == AdaptiveScreenType.tablet) {
        return Hero(
          tag: GLOBAL_APP_BAR_TAG,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: sizingInfo.screenSize.height,
            color: GlorifiColors.white,
            child: Row(
              children: [
                _glorifiTextLogo,
              ],
            ),
          ),
        );
      } else {
        return Hero(
          tag: GLOBAL_APP_BAR_TAG,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: sizingInfo.screenSize.height,
            color: GlorifiColors.white,
            child: Row(
              children: [
                _glorifiTextLogo,
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Size get preferredSize => Size(1.sw, 56.h);
}

class _AdaptiveDrawer extends StatelessWidget {
  const _AdaptiveDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.deviceType == AdaptiveScreenType.desktop) {
          return Container();
        } else {
          return Container(
            color: GlorifiColors.white,
            width: 428.w,
            height: 1.sh,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 81.h,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.clear,
                                color: GlorifiColors.white,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h),
                    _AppDrawerItemWidget(
                      callback: () => Get.toNamed(Routes.cockpit),
                      assetPath: GlorifiAssets.buildingCastle,
                      title: "Today",
                    ),
                    SizedBox(height: 10.h),
                    _AppDrawerItemWidget(
                      callback: () => Get.toNamed(Routes.snapshot),
                      assetPath: GlorifiAssets.creditCard,
                      title: "Snapshot",
                    ),
                    SizedBox(height: 10.h),
                    _AppDrawerItemWidget(
                      callback: () => Get.toNamed(Routes.accounts),
                      assetPath: GlorifiAssets.accounts,
                      title: "Accounts",
                    ),
                    SizedBox(height: 10.h),
                    _AppDrawerItemWidget(
                      callback: () => Get.toNamed(Routes.reward),
                      assetPath: GlorifiAssets.home,
                      title: "Rewards",
                    ),
                    SizedBox(height: 10.h),
                    _AppDrawerItemWidget(
                      callback: () =>
                          Get.toNamed(Routes.faqCategoriesListingScreen),
                      assetPath: GlorifiAssets.arrowup,
                      title: "Support",
                    ),
                    SizedBox(height: 10.h),
                    _AppDrawerItemWidget(
                      callback: () => Get.toNamed(Routes.exploreProducts),
                      assetPath: GlorifiAssets.chatBubble,
                      title: "Explore",
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

class _AdaptiveEndDrawer extends StatelessWidget {
  const _AdaptiveEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Container(
          width: 428.w,
          color: GlorifiColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileMenu(),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderTitleWidget extends StatelessWidget {
  const _HeaderTitleWidget({
    Key? key,
    required this.title,
    required this.imageAssets,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String imageAssets;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: bodySemiBold18Primary(
        color: GlorifiColors.darkBlue,
      ),
    );
  }
}

class _AppDrawerItemWidget extends StatelessWidget {
  const _AppDrawerItemWidget({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.callback,
  }) : super(key: key);

  final String assetPath;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 85.h,
        // width: 260.w,
        color: GlorifiColors.white,
        child: Text(
          title,
          style: captionSemiBold14Primary(
            color: GlorifiColors.darkBlue,
          ),
        ),
      ),
    );
  }
}

class AdaptiveScrollableScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final Color backgroundColor;
  final Widget? childNative;

  const AdaptiveScrollableScaffold(
      {Key? key,
      required this.child,
      required this.title,
      this.childNative,
      this.backgroundColor: Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          appBar: GlorifiAppBar(
            title: title,
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                      headerTitle: title,
                      showTrailingButton: false,
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 32.w
                              : 24.w),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 32.w
                              : 24.w,
                      vertical: 50.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1024,
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AdaptiveColumnScaffold extends StatelessWidget {
  final int length;
  final String title;
  final Function rowWidget;
  final Color backgroundColor;

  const AdaptiveColumnScaffold(
      {Key? key,
      required this.length,
      required this.rowWidget,
      required this.title,
      this.backgroundColor: Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollableScaffold(
      backgroundColor: backgroundColor,
      title: title,
      child: AdaptiveGrid(
        children: [
          ...List<AdaptiveGridItem>.generate(
              length,
              (index) => AdaptiveGridItem(
                    desktop: 50,
                    tablet: 50,
                    webMobile: 100,
                    nativeMobile: 100,
                    child: AdaptiveGridItem(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: rowWidget(
                          index,
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
