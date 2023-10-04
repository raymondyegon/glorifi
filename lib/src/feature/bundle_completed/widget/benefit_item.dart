import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/asset_image/AssetImageView.dart';

class BenefitItem extends StatelessWidget {
  final String title;
  final AdaptiveSizingInfo sizingInfo;

  const BenefitItem({
    Key? key,
    required this.sizingInfo,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageView(
            fileName: "icons/check.svg",
            color: GlorifiColors.superLightGrey,
            width: 24.sp,
          ),
          SizedBox(
            width: 12.w,
          ),
          Flexible(
            child: Text(
              title,
              style: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                  ? captionSemiBold16Primary(
                      color: GlorifiColors.superLightGrey)
                  : bodySemiBold18Primary(color: GlorifiColors.superLightGrey),
            ),
          ),
        ],
      ),
    );
  }
}
