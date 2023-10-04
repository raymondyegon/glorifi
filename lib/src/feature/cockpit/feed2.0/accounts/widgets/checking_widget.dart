import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CheckingWidget extends StatelessWidget {
  const CheckingWidget(
      {Key? key, required this.gloriFiAccountData, required this.onTap})
      : super(key: key);

  final GloriFiAccountData? gloriFiAccountData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.r),
            color: GlorifiColors.primaryButtonProgressColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(gloriFiAccountData!.getCurrentBalance(),
                    style: headlineBold26Secondary(color: GlorifiColors.white)),
                SvgPicture.asset(
                  GlorifiAssets.glorifiLogo,
                  color: GlorifiColors.white,
                  height: 9,
                  width: 27,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            contentWidget(
                header: "CD ", value: gloriFiAccountData!.accountNumber),
            SizedBox(
              height: 32.h,
            ),
            contentWidget(header: "APY: ", value: gloriFiAccountData!.apy),
            SizedBox(
              height: 5.h,
            ),
            contentWidget(
                header: "Interest Rates: ",
                value: gloriFiAccountData!.interestRate),
            SizedBox(
              height: 5.h,
            ),
            contentWidget(header: "Term: ", value: gloriFiAccountData!.term),
          ],
        ),
      ),
    );
  }

  Widget contentWidget({required String header, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(header, style: smallBold16Primary(color: GlorifiColors.white)),
        Text(value, style: smallSemiBold16Primary(color: GlorifiColors.white)),
      ],
    );
  }
}
