import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_service.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_fund_your_account_plaid_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_funding_accounts_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/transactions/ebs_transactions_list.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class EBSAccountDetailsScreen extends GetView<EBSController> {
  const EBSAccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: There is probably a better home for this - WC
    if (Get.arguments != null) {
      Get.put(EBSController(accountId: Get.arguments['accountId'].toString()));
    }

    return Obx(() {
      return EBSContainer(
        showAppbarShadow: false,
        screenBackground: GlorifiColors.white,
        title: controller.accountDetailTitle,
        appbarTextStyle: smallSemiBold16Primary(color: GlorifiColors.ebonyBlue),
        showSettings: !controller.loadingDetails.value && !controller.errorFetchingDetails.value,
        children: _content(),
      );
    });
  }

  List<Widget> _content() {
    final hasNoMonies = controller.details.availableBalance <= 0;
    if (controller.errorFetchingDetails.value) {
      return [_retry()];
    }
    return [
      controller.loadingDetails.value == true
          ? SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShimmeryPlaceHolder(radius: 0),
              ),
            )
          : _availableBalance(includeTransferControls: hasNoMonies),
      Obx(_zeroBalance),
      Expanded(
        child: controller.loadingTransactions.value == true
            ? Center(
                child: GlorifiSpinner(),
              )
            : EBSTransactionsList(
                showHeader: true,
                transactions: controller.transactions,
                loadingMoreTransactions: false,
              ),
      )
    ];
  }

  Widget _availableBalance({bool includeTransferControls = false}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: GlorifiColors.white, boxShadow: [
        BoxShadow(
          color: GlorifiColors.black.withOpacity(0.05),
          blurRadius: 14,
          offset: Offset(0, 4),
        )
      ]),
      child: Padding(
        padding: EdgeInsets.all(30.h),
        child: Column(
          children: [
            Text('Available Balance',
                textAlign: TextAlign.right,
                style:
                    captionSemiBold14Primary(color: GlorifiColors.greyProfile)),
            SizedBox(height: 8.h),
            Text(controller.details.availableBalance.formatCurrencyWithZero(),
                style: customGlorifiStyle(
                    size: 41,
                    weight: FontWeight.bold,
                    color: GlorifiColors.primaryButtonProgressColor)),
          ],
        ),
      ),
    );
  }

  Widget _zeroBalance() {
    if (controller.details.availableBalance > 0.0 ||
        controller.loadingDetails.value == true) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: GlorifiColors.darkBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Add funds to get started and take advantage of all the benfets that GloriFi offers!',
                style: customGlorifiStyle(
                    weight: FontWeight.w400,
                    size: 14,
                    color: GlorifiColors.white),
              ).paddingOnly(right: 50.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Ripple(
                    onTap: () {},
                    child: Text(
                      'Learn More',
                      style: customGlorifiStyle(
                          weight: FontWeight.bold,
                          size: 12,
                          color: GlorifiColors.lightBlue),
                    ),
                  ),
                  PrimaryButton(
                    title: 'Add Funds',
                    width: null,
                    onTap: () {
                      // Navigate to the Transfer screen when they want to add funds to a zero balance account
                      // TODO: Would be nice for this action to prefill the "TO" account upon arrival at transfer
                      Get.toNamed(Routes.ebsTransfer);

                      // Old implementation, not currenlty working as expected. May revive in the future. May delete. Dunno - WC
                      // //in case this screen will be used also for plaid accounts
                      // //we should probably change this
                      // final AccountsController _accountsController =
                      //     Get.find<AccountsController>();
                      // final bool _hasOtherAccounts = _accountsController
                      //             .myBankController
                      //             .connectedAccountData
                      //             .length >
                      //         0 ||
                      //     _accountsController.myBankController
                      //             .connectedGloriFiAccountData.length >
                      //         1;

                      // Get.put(OAOService());
                      // final OAOController _OAOController =
                      //     Get.put(OAOController(fromEBS: true));
                      // _OAOController.fetchFundingAccounts();
                      // if (_hasOtherAccounts) {
                      //   Get.to(() => OAOFundingAccountsScreen());
                      // } else {
                      //   Get.to(() => OAOFundYourAccountPlaidScreen());
                      // }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _retry() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 80),
          Text(
            'Oops! An unexpected error occurred.',
            style: headlineRegular31Secondary(color: GlorifiColors.cornflowerBlue),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Please try again later.',
            style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          PrimaryDarkButton(
            title: 'Retry',
            onTap: controller.retryDetails,
          ),
        ],
      ),
    );
  }
}
