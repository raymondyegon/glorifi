import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/mobile_deposit_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/model/account_data.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class MobileDepositToScreen extends GetView<MobileDepositController> {
  MobileDepositToScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBankController = Get.find<MyBankController>();
    controller.mobileDepositToAccounts.clear();
    int id = 0;
    myBankController.connectedGloriFiAccountData.forEach((account) {
      controller.mobileDepositToAccounts.add(AccountData(
          id: id++,
          name: account.accountName,
          number: account.accountNumber,
          balance: account.currentBalance));
    });

    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Mobile Deposit',
        trailing: Trailing(
            text: "Cancel",
            onTap: Get.back,
            textStyle: captionBold14Primary(color: GlorifiColors.bloodOrange)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 52.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Where would you like to deposit your check?",
                          style: leadRegular24Secondary(
                              color: GlorifiColors.biscayBlue)),
                      SizedBox(height: 16.h),
                      Text(
                          'Deposit by 11:59 PM CT and your money will typically be available '
                          'for withdrawal by the next business day.',
                          style: captionRegular14Primary(
                              color: GlorifiColors.midnightBlue)),
                      SizedBox(height: 39.h),
                      Obx(_buildAccounts),
                      const Spacer(),
                      _buildContinueButton()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccounts() {
    return Column(
      children: <Widget>[
        ...controller.mobileDepositToAccounts.map(_buildAccountField).toList(),
      ],
    );
  }

  Widget _buildAccountField(AccountData accountData) {
    return GestureDetector(
      onTap: () {
        controller.mobileDepositToChosenAccount.value = accountData;
        debugPrint("Mobile deposit to chosen account id: " +
            controller.mobileDepositToChosenAccount.value!.id.toString());
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2.w,
                  color: GlorifiColors.biscayBlue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: Row(
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: GlorifiColors.biscayBlue,
                  ),
                  child: Radio<AccountData>(
                      value: accountData,
                      groupValue: controller.mobileDepositToChosenAccount.value,
                      onChanged: (AccountData? value) {
                        controller.mobileDepositToChosenAccount.value = value;
                      },
                      activeColor: GlorifiColors.biscayBlue),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 11.h),
                      Text(
                        accountData.name + " (" + accountData.number + ")",
                        style: smallBold16Primary(),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Current balance: " +
                            accountData.balance.formatCurrencyWithZero(),
                        style: smallRegular16Primary(
                            color: GlorifiColors.spanishGray),
                      ),
                      SizedBox(height: 11.h),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Obx(() => (controller.mobileDepositToChosenAccount.value != null)
        ? PrimaryButton(
            title: "Continue",
            width: 335.w,
            height: 64.h,
            primaryColor: GlorifiColors.primaryButtonProgressColor,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            onTap: () => Get.toNamed(Routes.mobileDeposit),
          )
        : PrimaryButton(
            title: "Continue",
            width: 335.w,
            height: 64.h,
            iconColor: GlorifiColors.superLightGrey,
            primaryColor: GlorifiColors.silver,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            onTap: () => debugPrint("Account not selected."),
          ));
  }
}
