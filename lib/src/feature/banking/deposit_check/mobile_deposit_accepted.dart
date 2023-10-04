import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/mobile_deposit_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/model/account_data.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class MobileDepositAcceptedScreen extends GetView<MobileDepositController> {
  MobileDepositAcceptedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Mobile Deposit',
        leading: Leading(
          text: "",
          onTap: () => {},
        ),
      ),
      backgroundColor: GlorifiColors.midnightBlue,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 52.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.check_rounded,
                  color: GlorifiColors.electricGreenColor,
                  size: 64.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  "Deposit accepted",
                  style: headlineRegular31Secondary(
                      color: GlorifiColors.superLightGrey),
                ),
                SizedBox(height: 45.h),
                _buildRow("Amount",
                    controller.depositAmountValueController.value.text),
                _buildRow(
                    "Deposited to",
                    _formatAccountTypeNumber(
                        controller.mobileDepositToChosenAccount.value!)),
                _buildRow("Confirmation #",
                    controller.depositTransactionSequenceNumber.value),
                SizedBox(height: 7.h),
                PrimaryButton(
                  title: "Done",
                  width: 342.w,
                  height: 64.h,
                  onTap: () => Get.until(
                      (route) => route.settings.name == Routes.cockpit),
                ),
                SizedBox(height: 45.h),
                Text(
                  "Please hold on to your check to allow sufficient time for it to clear. The cutoff for deposits Monday through Friday, excluding federal holidays, is 11:59 PM CT. Checks deposited after the cutoff will be deposited the next business day. The status of your deposit can be seen in the Deposited Check in Banking navigation menu. If you have any questions regarding this transaction, call customer services on 844-456-7434.",
                  style: smallRegular16Primary(
                      color: GlorifiColors.superLightGrey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String left, String right) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              left,
              style:
                  smallSemiBold16Primary(color: GlorifiColors.superLightGrey),
            ),
            Text(
              right,
              style:
                  smallSemiBold16Primary(color: GlorifiColors.superLightGrey),
            ),
          ],
        ),
        Divider(
          color: GlorifiColors.superLightGrey,
        ),
        SizedBox(height: 15.h)
      ],
    );
  }

  String _formatAccountTypeNumber(AccountData account) {
    return account.name +
        " (..." +
        account.number.substring(account.number.length - 4) +
        ")";
  }
}
