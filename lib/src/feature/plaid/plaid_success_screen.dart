import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/event_broadcaster.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/fund/oao_funding_accounts_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_account_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class PlaidSuccessScreenArguments {
  final PlaidFlowType type;

  PlaidSuccessScreenArguments({this.type = PlaidFlowType.regular});
}

class PlaidSuccessScreen extends StatelessWidget {
  PlaidSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    PlaidSuccessScreenArguments? _args;
    if (Get.arguments is PlaidSuccessScreenArguments) {
      _args = Get.arguments;
    }
    return Scaffold(
      body: AdaptiveBuilder(builder: (context, sizingInfo) {
        bool isDesktop = sizingInfo.isDesktop;
        return Center(
          child: Container(
            width: isDesktop ? 672.w : width,
            height: isDesktop ? 437.h : null,
            decoration: BoxDecoration(
              color: Color(0xFF03213D),
              borderRadius: isDesktop ? BorderRadius.circular(16) : null,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF1BD760),
                  size: 60.sp,
                ),
                SizedBox(height: 32.h),
                Container(
                  width: 280.w,
                  child: Text(
                    "Your Account Was Linked!",
                    style: headlineRegular26Primary(
                      color: GlorifiColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    "Check back for updated data.",
                    style: smallSemiBold16Primary(
                      color: GlorifiColors.white,
                    ),
                  ),
                ),
                Container(
                  width: 342,
                  margin: const EdgeInsets.only(
                    top: 35.5,
                    bottom: 15,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (_args?.type == PlaidFlowType.funding) {
                        Get.find<OAOController>().fetchFundingAccounts();
                        Get.to(() => OAOFundingAccountsScreen());
                      } else if (_args?.type == PlaidFlowType.creditCard) {
                        CCPaymentsController ccPaymentsController = Get.find();
                        await ccPaymentsController.fetchFundingAccounts();
                        if (ccPaymentsController.fundingAccounts.length > 0) {
                          Get.off(() => CCPaymentAccountScreen());
                        } else {
                          Navigator.of(context).pop();
                        }
                      } else if (_args?.type == PlaidFlowType.oaoFunding) {
                        Get.find<OAOController>().fetchFundingAccounts();
                        Get.to(() => OAOFundingAccountsScreen());
                      } else if (_args?.type == PlaidFlowType.transferLinking) {
                        Get.find<TransferController>().resetTransferAccounts();
                        // FIXME: We intentionally go back an extra screen in hopes that the newly linked account will be available when the user re-enters
                        Get.back();
                        Get.back();
                      } else if (_args?.type == PlaidFlowType.checking) {
                        final cashOnHandController =
                            Get.find<CashOnHandController>();
                        cashOnHandController.mapGetCashOnHandData();
                        Get.back();
                        Get.back();
                      } else if (_args?.type == PlaidFlowType.savings) {
                        final cashOnHandController =
                            Get.find<CashOnHandController>();
                        cashOnHandController.mapGetCashOnHandData();
                        Get.back();
                        Get.back();
                      } else {
                        if (!sizingInfo.isDesktop) Get.back();
                        Get.back();
                      }
                      Get.find<ProfileController>().refreshProfile();
                      EventBroadcaster.instance
                          .addEvent(AccountsChangedEvent());
                    },
                    child: Center(
                      child: Text(
                        'Close',
                        style: bodyBold18Primary(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
