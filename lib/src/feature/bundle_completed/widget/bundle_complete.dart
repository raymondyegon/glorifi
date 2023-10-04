import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/asset_image/AssetImageView.dart';

class BundleComplete extends StatelessWidget {
  const BundleComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageView(fileName: "icons/successful.svg"),
          SizedBox(
            height: 38.h,
          ),
          Text(
            "Bundle Completed",
            style:
                headlineRegular31Secondary(color: GlorifiColors.superLightGrey),
          ),
        ],
      ),
    );
  }
}
