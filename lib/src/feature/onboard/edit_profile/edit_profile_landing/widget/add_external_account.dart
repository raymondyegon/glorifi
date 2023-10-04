import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../../../../../font_style_global.dart';

class AddExternalAccount extends StatelessWidget {
  final Function() onTap;

  const AddExternalAccount({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TextConstants.externalAccounts,
            style: bodyBold18Primary(color: GlorifiColors.darkBlue),
          ),
          _getAddButton()
        ],
      ).paddingAll(16.0.sp),
    );
  }

  Widget _getAddButton() {
    return Ripple(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            TextConstants.add,
            style: smallSemiBold16Primary(color: GlorifiColors.darkBlue),
          ).marginOnly(right: 8.w),
          SvgPicture.asset(
            "assets/images/add_external_account.svg",
            height: 18.h,
            width: 18.w,
          )
        ],
      ).paddingAll(8),
    );
  }
}
