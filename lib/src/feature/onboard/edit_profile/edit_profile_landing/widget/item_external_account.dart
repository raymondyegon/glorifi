import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

import '../../../../../font_style_global.dart';
import '../../../../../widgets/tap/ripple.dart';

class ItemExternalAccount extends StatelessWidget {
  final ExternalAccount account;
  final Function(ExternalAccount account) onTapUnlink;
  final bool isLastItem;

  const ItemExternalAccount({
    required this.account,
    required this.isLastItem,
    required this.onTapUnlink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: GlorifiColors.white,
            borderRadius: BorderRadius.all(Radius.circular(4.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name ?? '',
                      style: smallSemiBold16Primary(
                        color: GlorifiColors.darkBlue,
                      ),
                    ),
                    Text(
                      _getSubtitleText(),
                      style: captionSemiBold14Primary(
                        color: GlorifiColors.darkGrey,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 16.0.w),
              Ripple(
                onTap: () {
                  onTapUnlink(account);
                },
                child: Text(
                  TextConstants.unlink,
                  style: headlineBold21SecondarySans(
                    color: GlorifiColors.darkBlue,
                  ),
                ),
              )
            ],
          ).paddingOnly(
            top: 21.8.h,
            right: 19.0.w,
            bottom: 21.8.h,
            left: 24.0.w,
          ),
        ),
        if (!isLastItem) SizedBox(height: 6.h),
      ],
    );
  }

  String _getSubtitleText() {
    return "****${account.mask ?? ''} | ${account.institution ?? ''}";
  }
}
