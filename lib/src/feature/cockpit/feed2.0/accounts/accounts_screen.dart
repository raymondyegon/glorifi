import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/account_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/available_products.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/coming_soon_carousel.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/external_account_title.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/accounts_product_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/try_again_widget.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/product_modal_screen.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/products_screen.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_header.dart';
import 'package:glorifi/src/feature/credit_card/widgets/add_external_item_tile.dart';
import 'package:glorifi/src/feature/credit_card/widgets/bank_account_tile.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/containers/cockpit_tab_screen.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

import 'widgets/account_component.dart';
import 'widgets/bundle_component.dart';
import 'widgets/external_funding_accounts.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountsController());
    PlaidController plaidController = Get.put(PlaidController());

    pullToRefresh() async {
      await controller.pullRefresh();
    }

    Widget _content(AdaptiveSizingInfo sizingInfo) {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (sizingInfo.isNativeMobile) SizedBox(height: 19.h),
            if (sizingInfo.isNativeMobile) ProfileHeader(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizingInfo.isDesktop ? 200.w : 24.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizingInfo.isNativeMobile ? 35.h : 52.h,
                  ),
                  Text(
                    TextConstants.accounts,
                    style: headlineRegular32Primary(
                      color: GlorifiColors.darkBlueTint[800],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1024),
                    child: Obx(
                      () {
                        return sizingInfo.isDesktop
                            ? AdaptiveGrid(
                                gridSpacing: 8.0.sp,
                                children: [
                                  // open an account/ accounts
                                  getAccounts(
                                      sizingInfo, controller, plaidController),

                                  //products
                                  getProducts(sizingInfo, controller),
                                  // External linked accounts
                                  // getExternalAccounts(
                                  //     sizingInfo, controller, plaidController),

                                  //coming soon
                                  getComingSoon(sizingInfo, controller),

                                  //Glorifi bundles
                                  if (FeatureFlagManager.bundlesEnabled)
                                    getBundles(sizingInfo, controller),
                                ],
                              )
                            : AdaptiveGrid(
                                children: [
                                  // open an account/ accounts
                                  getAccounts(
                                      sizingInfo, controller, plaidController),
                                  // External linked accounts
                                  // getExternalAccounts(
                                  //     sizingInfo, controller, plaidController),
                                  //products
                                  getProducts(sizingInfo, controller),
                                  //Glorifi bundles
                                  if (FeatureFlagManager.bundlesEnabled)
                                    getBundles(sizingInfo, controller),
                                  //coming soon
                                  getComingSoon(sizingInfo, controller),
                                ],
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return sizingInfo.isNativeMobile
          ? CockpitTabScreen(
              onRefresh: () async => await pullToRefresh(),
              child: _content(sizingInfo))
          : AdaptiveScaffold(body: _content(sizingInfo));
    });
  }

  AdaptiveGridItem getAccounts(AdaptiveSizingInfo sizingInfo,
      AccountsController controller, PlaidController plaidController) {
    final bool haveLinkedAccounts =
        controller.myBankController.haveGloriFiAccounts;
    controller.haveGloriFiAccounts.value = haveLinkedAccounts;

    return AdaptiveGridItem(
      nativeMobile: 100,
      webMobile: 100,
      desktop: 50,
      tablet: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Obx(() => controller.myBankController.creditCardAccount.value
                          .accountNumber !=
                      ""
                  ? Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: GlorifiColors.white,
                      ),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  GlorifiAssets.creditCard,
                                  height: 24.h,
                                  width: 24.w,
                                  color: GlorifiColors.blueMidnightBlue,
                                ),
                                SizedBox(
                                  width: 14.h,
                                ),
                                Text(
                                  "Credit Card",
                                  style: bodySemiBold18Primary(
                                      color: GlorifiColors.blueMidnightBlue),
                                ),
                              ],
                            ).paddingSymmetric(
                                horizontal: 18.w, vertical: 24.h),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: GlorifiColors.darkBlue,
                              size: 18.h,
                            ).paddingOnly(right: 24.w)
                          ],
                        ).paddingSymmetric(horizontal: 8.h),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: GlorifiColors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r),
                              ),
                            ),
                            child: AccountItem(
                              onTap: () {
                                Get.toNamed(Routes.ccDashboard, arguments: {
                                  "accountModel": controller
                                      .myBankController.creditCardAccount.value,
                                  "isMockEnabled": controller
                                      .myBankController.isMockEnabled.value
                                });
                              },
                              data: GloriFiAccountData(
                                accountNumber: controller.myBankController
                                    .creditCardAccount.value.accountNumber,
                                accountName: "accountName",
                                type: controller.myBankController
                                    .creditCardAccount.value.type,
                                currentBalance: controller.myBankController
                                    .creditCardAccount.value.currentBalance,
                                isoCurrencyCode: "isoCurrencyCode",
                                apy: "apy",
                                interestRate: "interestRa",
                                term: "term",
                              ),
                            ))
                      ]))
                  : SizedBox.shrink()),
              SizedBox(
                height: 16.h,
              ),
              (controller.myBankController.errorFetchingGlorifiAccounts.value ==
                      true)
                  ? TryAgainWidget(
                      onTap: () => controller.myBankController.pullRefresh(),
                    )
                  : Obx(
                      () {
                        return controller
                                .myBankController.fetchingGlorifiAccounts.value
                            ? SizedBox(
                                height: 200.h,
                                child: ShimmeryPlaceHolder(),
                              )
                            : Column(
                                children: [
                                  haveLinkedAccounts
                                      ? AccountComponent(
                                          onDepositClick:
                                              controller.navigateToDeposit,
                                          onTransferClick:
                                              controller.navigateToTransfer,
                                          onFindAtmClick:
                                              controller.navigateToATMLocator,
                                          isButtonsDisabled: false,
                                        ).paddingOnly(
                                          bottom: 33.h,
                                        )
                                      : SizedBox.shrink(),
                                  ExternalFundingAccounts(
                                    accounts: controller.myBankController
                                        .externalFundingAccounts,
                                    onTap: () async =>
                                        await plaidController.openPlaid(
                                            flowType: PlaidFlowType.funding),
                                  ),
                                ],
                              );
                      },
                    )
            ],
          ),
        ],
      ).paddingOnly(
          right: sizingInfo.isDesktop || sizingInfo.isTablet ? 12.w : 0),
    );
  }

  AdaptiveGridItem getExternalAccounts(AdaptiveSizingInfo sizingInfo,
      AccountsController controller, PlaidController plaidController) {
    final externalAccountList =
        controller.myBankController.externalFundingAccounts;

    return AdaptiveGridItem(
      nativeMobile: 100,
      webMobile: 100,
      desktop: 50,
      tablet: 100,
      child: Column(
        children: [
          SizedBox(
            height: 32.h,
          ),
          ExternalAccountTitle(
            title: TextConstants.externalLinkedAccounts,
          ),
          SizedBox(
            height: 13.h,
          ),
          ...List.generate(externalAccountList.length, (index) {
            final data =
                controller.myBankController.externalFundingAccounts[index];
            return BankAccountTile(
              onTap: () {},
              balance: '',
              secretNumber: data.mask,
              bankName: data.name,
              accountType: data.institution,
            );
          }),
          SizedBox(
            height: 14.h,
          ),
          AddExternalItemTile(
            buttonText: TextConstants.linkAccounts,
            onTap: () async {
              await plaidController.openPlaid(flowType: PlaidFlowType.funding);
            },
            isAddIcon: true,
          ),
        ],
      ),
    );
  }

  AdaptiveGridItem getProducts(
    AdaptiveSizingInfo sizingInfo,
    AccountsController controller,
  ) {
    return AdaptiveGridItem(
      nativeMobile: 100,
      webMobile: 100,
      desktop: 50,
      tablet: 40,
      child: Obx(() {
        return AvailableProducts(
          sizingInfo: sizingInfo,
          selectedIndex: controller.availableProductsIndex.value,
          children: _availableProductsCards(),
        );
      }),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     if (FeatureFlagManager.insuranceEnabled == true)
      //       ProductTile(
      //         onTap: () {
      //           Get.toNamed(Routes.insuranceScreen);
      //         },
      //         title: TextConstants.insurance,
      //         asset: GlorifiAssets.shield,
      //         child: Column(
      //           children: [
      //             ...List.generate(
      //                 controller.insuranceController.activeInsuranceData.length,
      //                 (index) {
      //               final element = controller
      //                   .insuranceController.activeInsuranceData[index];
      //               return InsuranceTile(
      //                   onTap: () {
      //                     controller.insuranceController.gotoPolicyDetails(
      //                         policyType: element.policyName,
      //                         id: element.policyId.toString(),
      //                         name: element.policyName);
      //                   },
      //                   contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      //                   isActive: true,
      //                   status: TextConstants.active,
      //                   accountDetail: controller.insuranceController
      //                       .activeInsuranceData[index].displayIdentifier
      //                       .getPolicyDetails(),
      //                   loanType: controller.insuranceController
      //                       .activeInsuranceData[index].policyName);
      //             }),
      //             if (controller
      //                 .insuranceController.activeInsuranceData.isNotEmpty)
      //               SizedBox(
      //                 height: 32.h,
      //               )
      //           ],
      //         ),
      //       ),
      //     if (FeatureFlagManager.mortgageEnabled == true)
      //       ProductTile(
      //         onTap: () {
      //           Get.toNamed(Routes.mortgage);
      //         },
      //         title: TextConstants.mortgage,
      //         asset: GlorifiAssets.home,
      //         child: Column(
      //           children: [
      //             ...List.generate(
      //                 controller.mortgageController.activeMortgageData.length,
      //                 (index) {
      //               final element =
      //                   controller.mortgageController.activeMortgageData[index];
      //               return Column(
      //                 children: [
      //                   Divider(
      //                     thickness: 1,
      //                     color: GlorifiColors.altoGrey,
      //                   ),
      //                   MortgageApplicationTile(
      //                     element: element,
      //                   ),
      //                 ],
      //               );
      //             }),
      //             if (controller
      //                 .mortgageController.activeMortgageData.isNotEmpty)
      //               SizedBox(
      //                 height: 0.h,
      //               )
      //           ],
      //         ),
      //       ),
      //   ],
      // ).paddingOnly(
      //     left: sizingInfo.isDesktop || sizingInfo.isTablet ? 12.w : 0),
    );
  }

  AdaptiveGridItem getBundles(
    AdaptiveSizingInfo sizingInfo,
    AccountsController controller,
  ) {
    return AdaptiveGridItem(
      nativeMobile: 100,
      webMobile: 100,
      desktop: 50,
      tablet: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32.h,
          ),
          Obx(
            () => BundleComponent(
              bundleList: controller.bundleController.bundleList,
            ),
          ),
        ],
      ).paddingOnly(
          right: sizingInfo.isDesktop || sizingInfo.isTablet ? 12.w : 0),
    );
  }

  AdaptiveGridItem getComingSoon(
    AdaptiveSizingInfo sizingInfo,
    AccountsController controller,
  ) {
    return AdaptiveGridItem(
      // nativeMobile: 100,
      // webMobile: 100,
      // desktop: 50,
      // tablet: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => ComingSoonCarousel(
                children: _comingSoonCards(),
                selectedIndex: controller.comingSoonIndex.value,
              )),
          if (sizingInfo.isNativeMobile)
            SizedBox(
              height: 100.h,
            ),
        ],
      ).paddingOnly(
          left: sizingInfo.isDesktop || sizingInfo.isTablet ? 12.w : 0),
    );
  }

  List<Widget> _comingSoonCards() {
    return Get.find<FeatureFlagController>()
        .comingSoon
        .map((f) => _cardForFlaggableFeature(f, false))
        .toList();
  }

  List<Widget> _availableProductsCards() {
    return Get.find<FeatureFlagController>()
        .available
        .map((f) => _cardForFlaggableFeature(f, true))
        .toList();
  }

  Widget _cardForFlaggableFeature(FlaggableFeature f, bool isAvailable) {
    switch (f) {
      case FlaggableFeature.banking:
        return AccountsProductCard(
            onTap: () {
              if (isAvailable) {
                Get.toNamed(Routes.openBankAccount);
              } else {
                Get.bottomSheet(
                    ProductsScreen(
                      initialIndex: 2,
                      showCloseButton: true,
                    ),
                    isScrollControlled: true);
              }
            },
            imageName: 'assets/images/products/tmp_promo/banking_promo.png');
      case FlaggableFeature.mortgage:
        return AccountsProductCard(
            onTap: () {
              if (isAvailable) {
                Get.toNamed(Routes.mortgage);
              } else {
                Get.bottomSheet(
                    ProductsScreen(
                      initialIndex: 1,
                      showCloseButton: true,
                    ),
                    isScrollControlled: true);
              }
            },
            imageName: 'assets/images/products/tmp_promo/mortgage_promo.png');
      case FlaggableFeature.creditCard:
        return AccountsProductCard(
            onTap: () {
              if (isAvailable) {
                // TODO: Navigate to Credit Card Open Account
              } else {
                Get.bottomSheet(
                    ProductsScreen(
                      initialIndex: 0,
                      showCloseButton: true,
                    ),
                    isScrollControlled: true);
              }
            },
            imageName:
                'assets/images/products/tmp_promo/credit_card_promo.png');
      case FlaggableFeature.insurance:
        return AccountsProductCard(
            onTap: () {
              if (isAvailable) {
                // TODO: Navigate to Insurance
              } else {
                Get.bottomSheet(
                  ProductsScreen(
                    initialIndex: 3,
                    showCloseButton: true,
                  ),
                  isScrollControlled: true,
                );
              }
            },
            imageName: 'assets/images/products/tmp_promo/insurance_promo.png');
      default:
        return Container();
    }
  }
}
