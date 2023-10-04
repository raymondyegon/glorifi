import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../font_style_global.dart';

class PolicyDocuments extends StatelessWidget {
  const PolicyDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
          backgroundColor: GlorifiColors.midnightBlue,
          appBar: GlorifiAppBar(
            title: "Policy Documents",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 48.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      GlorifiAssets.license,
                      color: GlorifiColors.cornflowerBlue,
                    ),
                  ),
                  SizedBox(
                    height: 78.h,
                  ),
                  Text(
                    "Your carrier holds your  documents.",
                    style:
                        headlineRegular31Secondary(color: GlorifiColors.white)
                            .copyWith(height: 1.5),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: Get.width - 100,
                    child: Text(
                      "Please contact your provider for all your document needs.",
                      style: smallRegular16Primary(color: GlorifiColors.white)
                          .copyWith(height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  Text("Provider Contact",
                      style: headlineRegular21Secondary(
                          color: GlorifiColors.white)),
                  SizedBox(
                    height: 12.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: GlorifiColors.white,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        GlorifiAssets.phonePhone,
                        color: GlorifiColors.white,
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        "555 555-5555",
                        style:
                            smallSemiBold16Primary(color: GlorifiColors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
    });
  }
}
