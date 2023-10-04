import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card/controller/credit_card_controller.dart';
import 'package:glorifi/src/feature/credit_card/widgets/bank_account_tile.dart';
import 'package:glorifi/src/feature/credit_card/widgets/card_widget.dart';
import 'package:glorifi/src/feature/credit_card/widgets/products_screen_container.dart';
import 'package:glorifi/src/feature/credit_card/widgets/title_text_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../font_style_global.dart';
import 'widgets/add_external_item_tile.dart';
import 'widgets/link_card_title_widget.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(children: [
            CardWidget(
                cardHeading: "Glorifi Brass Card",
                cardDesc: "Best type of credit card you can get",
                color: GlorifiColors.lightGold,
                textColor: GlorifiColors.black,
                onTap: () {
                  controller.gotoApplicationPage(CARD_TYPE.BRASS_CARD);
                }),
            SizedBox(
              height: 24,
            ),
            CardWidget(
              cardHeading: "GloriFi Rewards Card",
              cardDesc: "Best type of credit card you can get",
              textColor: GlorifiColors.white,
              color: GlorifiColors.black,
              onTap: () {
                controller.gotoApplicationPage(CARD_TYPE.REWARDS_CARD);
              },
            ),
          ])
        ],
      ),
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (!sizingInfo.isNativeMobile) {
        return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.productsBgWhite,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PageHeader(
                      headerTitle: "Credit Card",
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                  SizedBox(
                    height: 5.h,
                  ),
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
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  AddExternalItemTile(
                                    isAddIcon: true,
                                    buttonText: "Link External Credit Card",
                                    onTap: () {},
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
              onTap: () {},
              text: "Apply",
              textStyle: captionBold14Primary(
                color: GlorifiColors.darkOrange,
              ),
            ),
          ),
          backgroundColor: GlorifiColors.productsScreenBgWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                accountOpenCards.paddingSymmetric(
                    horizontal: 24.w, vertical: 24.h),
                ProductsScreenContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TitleTextWidget(titleText: "Connected Credit Card"),
                    Obx(
                      () => controller.externalCreditCardData.isEmpty
                          ? Divider(
                              thickness: 1,
                              color: GlorifiColors.lightGrey,
                            )
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
                ))
              ],
            ),
          ),
        );
      }
    });
  }
}
