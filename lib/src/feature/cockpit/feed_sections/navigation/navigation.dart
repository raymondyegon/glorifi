import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../../font_style_global.dart';
import '../../../banking/controller/my_bank_controller.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _getRow({children}) {
      return Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ));
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isNativeMobile) {
        return Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            _getRow(children: [
              _NativeNavigationItem(
                title: "Banking",
                assetPath: GlorifiAssets.banking,
                route: Routes.myBanking,
              ),
              _NativeNavigationItem(
                title: "Credit Card",
                assetPath: GlorifiAssets.creditCard,
                route: Routes.creditCardScreen,
              ),
              _NativeNavigationItem(
                title: "Mortgage",
                assetPath: GlorifiAssets.home,
                route: Routes.mortgage,
              )
            ]),
            SizedBox(
              height: 20.h,
            ),
            _getRow(
              children: [
                _NativeNavigationItem(
                  title: "Insurance",
                  assetPath: GlorifiAssets.shield,
                  route: Routes.insuranceScreen,
                ),
                _NativeNavigationItem(
                  title: "Brokerage",
                  assetPath: GlorifiAssets.arrowup,
                  route: Routes.brokerageMainPage,
                ),
                _NativeNavigationItem(
                  title: "Support",
                  assetPath: GlorifiAssets.chatBubble,
                  route: Routes.faqCategoriesListingScreen,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        );
      } else {
        return Center(
            child: Wrap(
          runSpacing: 10.h,
          spacing: 10.h,
          children: [
            _WebNavigationItem(
              assetPath: GlorifiAssets.buildingCastle,
              title: "Banking",
              onTap: () => Get.toNamed(Routes.openBankAccount),
            ),
            _WebNavigationItem(
              assetPath: GlorifiAssets.creditCard,
              title: "Credit Card",
              onTap: () => Get.toNamed(Routes.creditCardScreen),
            ),
            _WebNavigationItem(
              assetPath: GlorifiAssets.shield,
              title: "Insurance",
              onTap: () => Get.toNamed(Routes.insuranceScreen),
            ),
            _WebNavigationItem(
              assetPath: GlorifiAssets.home,
              title: "Loan",
              onTap: () => Get.toNamed(Routes.mortgage),
            ),
            _WebNavigationItem(
              assetPath: GlorifiAssets.arrowup,
              title: "Insight",
              onTap: () => Get.toNamed(Routes.insightsLandingPage),
            ),
            _WebNavigationItem(
              assetPath: GlorifiAssets.chatBubble,
              title: "Support",
              onTap: () => Get.toNamed(Routes.faqCategoriesListingScreen),
            ),
          ],
        ));
      }
    });
  }
}

class _NativeNavigationItem extends StatelessWidget {
  const _NativeNavigationItem({
    Key? key,
    required this.title,
    required this.assetPath,
    required this.route,
  }) : super(key: key);

  final String title;
  final String assetPath;
  final route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => route == Routes.myBanking
          ? Get.offNamed(Routes.openBankAccount)
          : Get.toNamed(route),
      child: Container(
        height: 70.h,
        width: 95.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 1), //(x,y)
              blurRadius: 25,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              assetPath,
              height: 20.h,
              width: 20.w,
              color: Colors.deepOrangeAccent,
            ),
            Flexible(
              child: Text(
                title,
                style: xSmallBold12Primary(
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebNavigationItem extends StatelessWidget {
  const _WebNavigationItem({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 85,
        width: 124,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        color: Color(0xff152951),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetPath,
              height: 20.h,
              width: 20.w,
              color: GlorifiColors.white,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: captionSemiBold14Primary(
                color: GlorifiColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
