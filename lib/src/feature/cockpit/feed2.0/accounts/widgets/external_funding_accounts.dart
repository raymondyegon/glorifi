import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ExternalFundingAccounts extends StatelessWidget {
  final onTap;
  final List<LinkedAccounts> accounts;

  const ExternalFundingAccounts({Key? key, this.onTap, required this.accounts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool loading = false.obs;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: GlorifiColors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    TextConstants.externalFundingAccounts,
                    style: bodyBold18Primary(
                      color: GlorifiColors.almostBlack,
                    ),
                  ),
                ),

              ],
            ).paddingSymmetric(
              vertical: 21.h,
              horizontal: 20.w,
            ),
            Divider(
              color: GlorifiColors.greyD9,
            ).paddingOnly(
                bottom: 16.h,
                left: 20.w,
              ),
              ...accounts.map(_externalAccountRow).toList(),
              Divider(
                color: GlorifiColors.greyD9,
              ).paddingOnly(
                bottom: 16.h,
                left: 20.w,
              ),
            Ripple(
              onTap: loading.value
                  ? () {}
                  : () async {
                      try {
                        loading.value = true;
                        // setState(() {});
                        await onTap!();
                      } finally {
                        loading.value = false;
                        // setState(() {});
                      }
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  loading.value
                      ? Container(
                          width: 22.w,
                          height: 22.w,
                          child: GlorifiSpinner(
                            size: 16,
                          ),
                        ).paddingOnly(
                          right: 10.5.w,
                        )
                      : SvgPicture.asset(
                          GlorifiAssets.linkIcon,
                          height: 16.h,
                        ).paddingOnly(
                          right: 10.5.w,
                        ),
                  Text(
                    TextConstants.linkAccounts,
                    style: captionBold14Primary(
                      color: GlorifiColors.blueIcon,
                    ),
                  )
                ],
              ).paddingOnly(
                bottom: 21.h,
              ),
            )
          ],
        ),
      );
      },
    );
  }

  // TODO: Lifted from transfer_account_select.dart. Candidate to be lifted to a shared widget
  Widget _externalAccountRow(LinkedAccounts account) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.name,
                style: TextStyle(
                  color: Color(0xFF1F3B73),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                ),
              ),
              Text(
                account.institution,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF36495A),
                  fontSize: 16,
                  fontFamily: "OpenSans",
                ),
              )
            ],
          ),
          Text(
            "*${account.mask}",
            style: TextStyle(
              color: Color(0xFF36495A),
              fontSize: 16,
              fontFamily: "OpenSans",
            ),
          ),
        ],
      ),
    );
  }
}
