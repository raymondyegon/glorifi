import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card/controller/credit_card_controller.dart';
import 'package:glorifi/src/feature/credit_card/widgets/bank_account_tile.dart';
import 'package:glorifi/src/feature/credit_card/widgets/products_screen_container.dart';
import 'package:glorifi/src/feature/credit_card/widgets/title_text_widget.dart';
import 'package:glorifi/src/feature/insurance/widgets/banner_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../font_style_global.dart';
import 'widgets/add_external_item_tile.dart';
import 'widgets/link_card_title_widget.dart';
import 'widgets/loan_tile.dart';

class CreditCardScreen extends StatelessWidget {
  const CreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreditCardController>();

    var accountOpenCards = AdaptiveGridItem(
      desktop: 60,
      tablet: 100,
      nativeMobile: 100,
      webMobile: 100,
      child: BannerWidget(
        image: GlorifiAssets.creditCardBackground,
        height: 300,
        bannerMainText: "Explore our GloriFi \ncredit cards",
        bannerSubText: "See Credit Cards",
        onTap: controller.navigateToWelcomeToGlorifiScreen,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (!sizingInfo.isNativeMobile) {
        return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.productsBgWhite,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                      headerTitle: "Credit Card",
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                  SizedBox(height: 5.h),
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
                        children: [
                          accountOpenCards,
                          AdaptiveGridItem(
                            desktop: 40,
                            tablet: 100,
                            webMobile: 100,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizingInfo.isDesktop ? 32.w : 0,
                                  top: sizingInfo.isTablet ? 32.h : 0),
                              child: Column(
                                children: [
                                  LinkCardTitleWidget(onTap: () {}).paddingOnly(
                                      top: sizingInfo.isDesktop ? 0 : 10.h),
                                  SizedBox(height: 24.h),
                                  AddExternalItemTile(
                                    isAddIcon: true,
                                    buttonText: "Link External Credit Card",
                                  ),
                                  Column(
                                    children: controller.externalCreditCardData
                                        .map((creditCard) {
                                      return BankAccountTile(
                                        onTap: () {},
                                        balance:
                                            // ignore: use_raw_strings
                                            "\$" + creditCard.currentBalance,
                                        secretNumber:
                                            "*" + creditCard.maskedNumbers,
                                        bankName: creditCard.fullName,
                                        accountType: creditCard.name,
                                      );
                                    }).toList(),
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
            ));
      } else {
        return Scaffold(
          appBar: GlorifiAppBar(
            title: "Credit Card",
            trailing: Trailing(
              onTap: controller.navigateToBlend,
              text: "Apply",
              textStyle: captionBold14Primary(color: GlorifiColors.darkOrange),
            ),
          ),
          backgroundColor: GlorifiColors.productsScreenBgWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                accountOpenCards.paddingSymmetric(
                    horizontal: 20.w, vertical: 20.h),
                ProductsScreenContainer(
                    child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      controller.externalCreditCardData.isEmpty
                          ? Offstage()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleTextWidget(
                                    titleText: "Pending Application"),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Column(
                                    children: controller.activeCreditCardData
                                        .map((element) {
                                  return LoanTile(
                                      onTap: () {},
                                      isActive: true,
                                      status: element.status ==
                                              "Application in Progress"
                                          ? "PENDING"
                                          : element.status,
                                      accountDetail: element.createdDate,
                                      loanType: element.loanPurposeType);
                                }).toList()),
                                SizedBox(
                                  height: 40.h,
                                ),
                              ],
                            ),
                      TitleTextWidget(titleText: "Connected Credit Card"),
                      SizedBox(
                        height: 16.h,
                      ),
                      controller.externalCreditCardData.isEmpty
                          ? Offstage()
                          : Column(
                              children: controller.externalCreditCardData
                                  .map((creditCard) {
                                return BankAccountTile(
                                  onTap: () {},
                                  balance:
                                      // ignore: use_raw_strings
                                      "\$" + creditCard.currentBalance,
                                  secretNumber: "*" + creditCard.maskedNumbers,
                                  bankName: creditCard.fullName,
                                  accountType: creditCard.name,
                                );
                              }).toList(),
                            ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AddExternalItemTile(
                        buttonText: "Link External Credit Card",
                        isAddIcon: true,
                        onTap: controller.navigateToPlaid,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      }
    });
  }
}
