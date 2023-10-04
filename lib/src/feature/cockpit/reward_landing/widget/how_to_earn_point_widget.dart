import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/widget/item_point_earning_action.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class HowToEarnPointWidget extends StatelessWidget {
  final List<PointEarningRuleUiModel> earnPointFinancialAccount;

  const HowToEarnPointWidget(this.earnPointFinancialAccount, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return Container(
        color: GlorifiColors.primaryButtonProgressColor,
        child: Center(
          child: Container(
            width: 1024,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earn Points With Your GloriFi Mastercard® Credit Cards.',
                  style: leadRegular24Secondary(color: GlorifiColors.white),
                ).marginOnly(
                  top: 4.h,
                ),
                SizedBox(height: 20.h),
                //Divider(thickness: 2.h, height: 24.h, color: GlorifiColors.silver),
                Text(
                  'Spend smart with a credit card that empowers you to put your money where your values are.',
                  style: smallRegular16Primary(color: GlorifiColors.white),
                ).marginOnly(
                  top: 16.h,
                ),
                (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: earnPointFinancialAccount.length,
                        itemBuilder: (context, index) {
                          var model = earnPointFinancialAccount[index];

                          return ItemPointEarningAction(
                            model: model,
                            onTap: null,
                            isBackgroundDark: true,
                          );
                        },
                      )
                    : Row(
                        children: earnPointFinancialAccount.map((e) {
                          return Expanded(
                            child: ItemPointEarningAction(
                              model: e,
                              onTap: null,
                              isBackgroundDark: true,
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ).paddingSymmetric(
                horizontal: sizingInfo.isDesktop ? 0.w : 25.w, vertical: 54.h),
          ),
        ),
      );
    });
  }
}
