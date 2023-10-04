import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_reward.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class AccOfferBrassCardDetailsScreen extends StatelessWidget {
  const AccOfferBrassCardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          elevation: 0,
          title: "",
          bgColor: GlorifiColors.bgColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: Image.asset(
                GlorifiAssets.glorifiGoldCreditCardDark,
                width: 184.w,
                height: 115.h,
              ),
            ),
            CCReward(
              title: "2% rewards on every purchase",
              desc:
                  "For every dollar you spend, you earn 2 reward points. These points can be redeemed for a variety of perks, ranging from cash back to donating to the Tunnel to Towers Foundation. ",
              reward: "2%",
              apr: '14.74%-24.74%',
              annualFee: 525,
              isFromBrassDetailsScreen: true,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 24.0),
              child: PrimaryButton(
                title: "Get this card",
                textColor: GlorifiColors.grey,
                primaryColor: GlorifiColors.primaryButtonProgressColor,
                hasRightArrow: true,
                onTap: () {
                  Get.toNamed(Routes.accAcceptCardAgreement);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
