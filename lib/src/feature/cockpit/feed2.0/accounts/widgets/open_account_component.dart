import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/model/open_account.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class OpenAccountComponent extends StatelessWidget {
  const OpenAccountComponent(
      {Key? key, required this.openAccount, required this.onTap})
      : super(key: key);

  final OpenAccount openAccount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            openAccount.accountType,
            style: bodyBold18Primary(color: GlorifiColors.white),
          ),
          Text(openAccount.ctaName!,
              style: bodyBold18Primary(color: GlorifiColors.white))
        ],
      ).paddingSymmetric(vertical: 12.h),
    );
    ;
  }
}
