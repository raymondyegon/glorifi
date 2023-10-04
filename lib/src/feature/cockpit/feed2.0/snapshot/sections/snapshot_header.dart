import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class SnapshotHeader extends StatelessWidget {
  const SnapshotHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      final bool isMobile = sizingInfo.isWebMobile || sizingInfo.isNativeMobile;
      return Padding(
        padding: EdgeInsets.only(
          top: isMobile ? 30 : 64,
          bottom: isMobile ? 0 : 69,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: isMobile ? 24.0.w : 0,
                ),
                child: Text(
                  "Snapshot",
                  textScaleFactor: 1,
                  style: headlineBold26Secondary(
                    color: GlorifiColors.almostBlack,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.managePersonalSnapshotScreen);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  top: 8.h,
                  bottom: 8.h,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: isMobile ? 0 : 14),
                      child: SvgPicture.asset(
                        GlorifiAssets.settings_snap,
                        color: GlorifiColors.almostBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: isMobile ? 24.0.w : 0),
          ],
        ),
      );
    });
  }
}
