import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_skip_fund_button.dart';
import 'package:glorifi/src/feature/banking/widgets/outlined_button_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class OAOFundingAccountsScreen extends GetView<OAOController> {
  const OAOFundingAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  List<Widget> _content() {
    return [
        Text(
          'Accounts',
          style: TextStyle(fontSize: 18),
        ).paddingOnly(bottom: 8),
        if(controller.fundingAccountsData.value != null)
        Text(
            'Last updated less than ${DateTime.now().difference(controller.fundingAccountsData.value!.updated).inMinutes} minutes ago'),
        if (controller.fundingAccountsData.value != null &&
            controller.fundingAccountsData.value?.glorifiAccounts.length == 0 &&
            controller.fundingAccountsData.value?.glorifiAccounts.length == 0)
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Text(
            'No connected accounts.',
            style: captionRegular14Primary(color: GlorifiColors.grey),
          ),
        ),
      SizedBox(height: 16.h),
      if (controller.fundingAccountsData.value != null)
          ...controller.fundingAccountsData.value!.glorifiAccounts
              .where((element) => !element.disabled)
            .map(
              (item) => FundingAccountItem(
                  balance: item.balance,
                institutionName: 'GloriFi',
                mask: item.accountNumber.substring(
                    item.accountNumber.length - 4, item.accountNumber.length),
                name: item.accountName ?? '',
                  status: '1',
                selectedProductGroup: controller
                    .applicationInProgress.value.selectedProduct?.group,
                onTap: () {
                  controller.selectFundingAccount(item);
                },
              ),
            )
            .toList(),
      if (controller.fundingAccountsData.value != null)
          ...controller.fundingAccountsData.value!.linkedAccounts
              .where((element) => !element.disabled)
              .map(
                (item) => FundingAccountItem(
                  balance: item.balance,
                  institutionName: item.institution ?? '',
                  mask: item.mask ?? '',
                  name: item.name ?? '',
                  status: item.status ?? '',
                  selectedProductGroup: controller.applicationInProgress.value.selectedProduct?.group,
                  onTap: () {
                    controller.selectFundingAccount(item);
                  },
                ),
              )
              .toList(),
        if (controller.fundingAccountsData.value != null)
        Text(
                controller.fundingAccountsData.value!.numberDisabledAccounts == 0
                    ? ""
                    : "Not able to fund with ${controller.fundingAccountsData.value!.numberDisabledAccounts == 1 ? "this" : "these"} account${controller.fundingAccountsData.value!.numberDisabledAccounts == 1 ? "" : "s"}",
                style: TextStyle(color: GlorifiColors.redError))
            .paddingSymmetric(vertical: 20),
        if (controller.fundingAccountsData.value != null)
          ...controller.fundingAccountsData.value!.glorifiAccounts
              .where((element) => element.disabled)
              .map(
                (item) => FundingAccountItem(
                  isDisabled: true,
                  balance: item.balance,
                  institutionName: 'GloriFi',
                  mask: item.accountNumber.substring(item.accountNumber.length - 4, item.accountNumber.length),
                  name: item.accountName ?? '',
                  status: '1',
                  selectedProductGroup: controller.applicationInProgress.value.selectedProduct?.group,
                  onTap: () {
                    controller.selectFundingAccount(item);
                  },
                ),
              )
              .toList(),
        if (controller.fundingAccountsData.value != null)
          ...controller.fundingAccountsData.value!.linkedAccounts
              .where((element) => element.disabled)
              .map(
                (item) => FundingAccountItem(
                  isDisabled: true,
                  balance: item.balance,
                  institutionName: item.institution ?? '',
                  mask: item.mask ?? '',
                  name: item.name ?? '',
                  status: item.status ?? '',
                selectedProductGroup: controller
                    .applicationInProgress.value.selectedProduct?.group,
                onTap: () {
                  controller.selectFundingAccount(item);
                },
              ),
            )
            .toList(),
      SizedBox(height: 16.h),
        OutlinedButtonWidget(
          icon: Image.asset('assets/images/addIcon.png'),
        text: 'Add an External Account',
        onTap: () async {
          PlaidController _plaidController = Get.put(PlaidController());
          await _plaidController.openPlaid(flowType: PlaidFlowType.funding);
        },
      ),
        SizedBox(height: 48.h),
      OAOFooterNote(
        customText: TextSpan(
            text:
                'GloriFi Financial uses Plaid Inc. (“Plaid”) to gather your data from financial institutions. By using the Service, you grant GloriFi Financial and Plaid the right, power, and authority to act on your behalf to access and transmit your personal and financial information from your relevant financial institution. You agree to your personal and financial information being transferred, stored, and processed by Plaid in accordance with the ',
            children: [
              //TODO add url
              textSpanHyperLink(
                  text: 'Plaid end user Privacy Policy.',
                  url: 'https://www.google.com'),
            ]),
      ),
        SizedBox(height: 50.h),
        OAOSkipFundButton(),
        SizedBox(height: 60.h),
    ];
  }
    return Obx(
      () => controller.loading.value
          ? Scaffold(body: Center(child: GlorifiSpinner()))
          : OAOContainer(
              info: OAOScreensInfo.OAOFundingAccountsScreen,
              children: _content(),
              showBackButton: controller.fromEBS,
            ),
    );
}

}
class FundingAccountItem extends StatelessWidget {
  final String name;
  final String mask;
  final String institutionName;
  final double balance;
  final String status;
  final bool isSelected;
  final Function()? onTap;
  final String? selectedProductGroup;
  final bool isDisabled;

  const FundingAccountItem({
    Key? key,
    required this.name,
    required this.mask,
    required this.institutionName,
    required this.balance,
    this.onTap,
    this.status = '',
    this.isSelected = false,
    this.selectedProductGroup,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _borderColor = GlorifiColors.white;
    Color _backgroundColor = GlorifiColors.white;

    if (isSelected) {
      _borderColor = GlorifiColors.selectedIndicatorColor;
      _backgroundColor = GlorifiColors.selectedBackgroundColor;
    }

    if (isDisabled) {
      _borderColor = GlorifiColors.greyD9;
      _backgroundColor = GlorifiColors.greyD9;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: _borderColor),
              color: _backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              boxShadow: boxShadowField,
            ),
            padding: EdgeInsets.fromLTRB(24, 22, 16, 22),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: smallSemiBold16Primary(
                          color: isDisabled
                              ? GlorifiColors.grey9E
                              : GlorifiColors.cornflowerBlue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '$institutionName | *$mask',
                          style: captionSemiBold14Primary(
                            color: isDisabled
                                ? GlorifiColors.grey9E
                                : GlorifiColors.denimBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  balance.formatCurrencyWithZero(),
                  maxLines: 1,
                  style: headlineBold21Secondary(
                    color: isDisabled
                        ? GlorifiColors.grey9E
                        : GlorifiColors.cornflowerBlue,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
