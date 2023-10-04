import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../font_style_global.dart';
import '../../widgets/appbars/glorifi_appbar.dart';
import 'controller/my_bank_controller.dart';
import 'widgets/glorifi_account_card.dart';

class MyBankingScreen extends StatelessWidget {
  const MyBankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyBankController>();

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          appBar: GlorifiAppBar(
            title: 'Banking',
            trailing: Trailing(
              text: 'Support',
              onTap: controller.navigateToFAQ,
            ),
          ),
          backgroundColor: GlorifiColors.productsBgWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (!sizingInfo.isNativeMobile)
                            Container(
                              height: 100.h,
                              width: double.infinity,
                              color: GlorifiColors.lighterGrey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizingInfo.isDesktop
                                      ? 200.w
                                      : sizingInfo.isTablet
                                          ? 34.5.w
                                          : sizingInfo.isWebMobile
                                              ? 24.5.w
                                              : 23.75.w),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1024),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Banking",
                                      style: headlineBold26Secondary(
                                        color: GlorifiColors.cornflowerBlue,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: controller.navigateToBackBase,
                                      child: Row(
                                        children: [
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: SvgPicture.asset(
                                              GlorifiAssets.icOverflow,
                                            ),
                                          ),
                                          Text(
                                            "Manage",
                                            style: captionSemiBold14Primary(
                                              color: GlorifiColors
                                                  .midnightBlueColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 23.h,
                          ),
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
                                gridSpacing: sizingInfo.isDesktop ? 15 : 0,
                                children: [
                                  AdaptiveGridItem(
                                    desktop: 33,
                                    tablet: 100,
                                    webMobile: 100,
                                    child: GlorifiAccountCard(
                                      title: 'GloriFi Checking',
                                      subTitle:
                                          'One of the best checking accounts you can get.',
                                      accountType: AccountType.NONE.name,
                                      image: GlorifiAssets.bankingCheckingBg,
                                      sizingInfo: sizingInfo,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.welcomeToGlorifi,
                                          arguments: {
                                            "screen": "Banking",
                                            "accountType": AccountType.CHECKING,
                                            "connected": false,
                                            "plaidAccount": false,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  AdaptiveGridItem(
                                    desktop: 33,
                                    tablet: 100,
                                    webMobile: 100,
                                    child: GlorifiAccountCard(
                                      title: 'GloriFi Saving',
                                      subTitle:
                                          'Earn 0.5% APY on all balances.\n',
                                      accountType: AccountType.NONE.name,
                                      image: GlorifiAssets.bankingSavingBg,
                                      sizingInfo: sizingInfo,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.welcomeToGlorifi,
                                          arguments: {
                                            "screen": "Banking",
                                            "accountType": AccountType.SAVINGS,
                                            "connected": false,
                                            "plaidAccount": false,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  AdaptiveGridItem(
                                    desktop: 33,
                                    tablet: 100,
                                    webMobile: 100,
                                    child: GlorifiAccountCard(
                                      title: 'GloriFi Certificate of Deposit',
                                      subTitle:
                                          'Personal Certificate of Deposit\n',
                                      image: GlorifiAssets.bankingCDBg,
                                      accountType: AccountType.NONE.name,
                                      sizingInfo: sizingInfo,
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.welcomeToGlorifi,
                                          arguments: {
                                            "screen": "Banking",
                                            "accountType": AccountType.CD,
                                            "connected": false,
                                            "plaidAccount": false,
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  /*AdaptiveGridItem(
                                    desktop: 100,
                                    tablet: 100,
                                    webMobile: 100,
                                    nativeMobile: 100,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: sizingInfo.isDesktop ? 0.w : 0),
                                      child: LinkedBankAccounts(onTap: () {
                                        Get.toNamed(
                                          Routes.openAccount,
                                          arguments: {
                                            "accountType": AccountType.SAVINGS,
                                            "connected": true,
                                            "plaidAccount": true,
                                          },
                                        );
                                      }),
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
