import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/insurance/controller/insurance_controller.dart';
import 'package:glorifi/src/feature/insurance/widgets/roadside_content_tile.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class RoadsideAssistance extends StatelessWidget {
  const RoadsideAssistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InsuranceController>();
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
          backgroundColor: GlorifiColors.bgColor,
          appBar: GlorifiAppBar(
            title: "Roadside Assistance",
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isTablet
                            ? 34.5.w
                            : 24.5.w,
                    vertical: sizingInfo.isDesktop ? 50.h : 20.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1024),
                  child: Column(
                    crossAxisAlignment:
                        (sizingInfo.isDesktop || sizingInfo.isTablet)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "What your Policy Covers:",
                        style: leadRegular24Secondary(
                            color: GlorifiColors.cornflowerBlue),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: sizingInfo.isDesktop ? 50.w : 24.h),
                          child: AdaptiveGrid(
                            children: [
                              ...List<AdaptiveGridItem>.generate(
                                controller.roadsideAssistanceData.length,
                                (index) => AdaptiveGridItem(
                                  nativeMobile: 100,
                                  webMobile: 100,
                                  tablet: 100,
                                  desktop: 50,
                                  child: RoadsideContentTile(
                                    roadsideAssistanceData: controller
                                        .roadsideAssistanceData[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      PrimaryDarkButton(
                        title: "Call For Assistance",
                        height: 56.h,
                        onTap: controller.callForAssistance,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
