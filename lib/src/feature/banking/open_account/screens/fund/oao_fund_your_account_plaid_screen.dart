import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_skip_fund_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class OAOFundYourAccountPlaidScreen extends GetView<OAOController> {
  const OAOFundYourAccountPlaidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _content() {
      PlaidController plaidController = Get.put(PlaidController());

      return [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: GlorifiColors.white,
            boxShadow: [
              BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(0.1))
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SvgPicture.asset(GlorifiAssets.plaid_logo),
            SizedBox(height: 12.h),
            Text(
              'Link Accounts via Plaid',
              style: headlineSemiBold31Primary(
                color: GlorifiColors.cornflowerBlue,
              ).copyWith(height: 40 / 31),
            ),
            SizedBox(height: 12.h),
            Text(
              'Plaid securely links your accounts from other banks in seconds so you can easily transfer money into your new GloriFi account.',
              style:
                  captionRegular14Primary(color: GlorifiColors.cornflowerBlue)
                      .copyWith(height: 24 / 14),
            ),
            SizedBox(height: 32.h),
            Obx(
              () => PrimaryDarkButton(
                height: 64.h,
                title: 'Link Account',
                isLoading: plaidController.isLoading.value,
                onTap: () async {
                  PlaidController _plaidController = Get.put(PlaidController());
                  await _plaidController.openPlaid(
                      flowType: PlaidFlowType.oaoFunding);
                },
              ),
            ),
            OAOFooterNote(
              plainText:
                  "GloriFi Financial uses Plaid Inc. (“Plaid”) to gather your data from financial institutions. By using the Service, you grant GloriFi Financial and Plaid the right, power, and authority to act on your behalf to access and transmit your personal and financial information from your relevant financial institution. By continuing you agree to your personal and financial information being transferred, stored, and processed by Plaid in accordance with the Plaid End User Privacy Policy.",
            ).paddingOnly(top: 20)
          ]),
        ),
        SizedBox(height: 40.h),
        OAOSkipFundButton(),
        SizedBox(height: 20.h),
      ];
    }

    return OAOContainer(
        info: OAOScreensInfo.OAOFundYourAccountPlaidScreen,
        children: _content(),
        showBackButton: controller.fromEBS
    );
  }
}
