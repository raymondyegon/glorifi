import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundle_completed/controllers/bundle_complete_controller.dart';
// import 'package:glorifi/src/feature/bundle_completed/widget/bundle_complete.dart';
// import 'package:glorifi/src/feature/bundle_completed/widget/your_benefit.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
// import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
// import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
// import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class BundleCompleteScreen extends GetView<BundleCompleteController> {
  BundleCompleteScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) => AdaptiveScaffold(
        backgroundColor: GlorifiColors.midnightBlue,
        showSimpleAppBar: sizingInfo.isWebMobile ? false : true,
        appBar: GlorifiAppBar(
          title: '',
          bgColor: GlorifiColors.midnightBlue,
          leadingIconDefaultColor: Colors.white,
        ),
        body: SafeArea(
          child: Container(
            width: Get.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    controller.argumentData.bundleName + " Complete",
                    style: TextStyle(
                      fontFamily: "univers",
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 208.0),
                  child: Column(
                    children: [
                      Text(
                        'You received',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                        ),
                        child: Text(
                          '${controller.argumentData.pointsAwarded.toString()} Bonus Points ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'for bundling with GloriFi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: sizingInfo.isDesktop
  //                       ? 200.w
  //                       : sizingInfo.isTablet
  //                           ? 32.w
  //                           : 24.w,
  //                   //vertical: (!sizingInfo.isDesktop) ? 64.h : 0,
  //                 ).copyWith(
  //                   top: (!sizingInfo.isDesktop) ? 64.h : 0,
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     (sizingInfo.isDesktop)
  //                         ? Center(
  //                             child: _getGridItems(sizingInfo),
  //                           )
  //                         : _getGridItems(sizingInfo),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ));
  // }

  // Widget _getGridItems(AdaptiveSizingInfo sizingInfo) {
  //   return AdaptiveGrid(
  //     children: [
  //       AdaptiveGridItem(
  //         nativeMobile: 100,
  //         tablet: 100,
  //         desktop: 50,
  //         webMobile: 100,
  //         child: const BundleComplete(),
  //       ),
  //       if (!sizingInfo.isDesktop)
  //         AdaptiveGridItem(
  //           nativeMobile: 100,
  //           tablet: 100,
  //           webMobile: 100,
  //           child: SizedBox(
  //             height: 72.h,
  //           ),
  //         ),
  //       AdaptiveGridItem(
  //         nativeMobile: 100,
  //         tablet: 100,
  //         desktop: 50,
  //         webMobile: 100,
  // child: YourBenefit(
  //   sizingInfo: sizingInfo,
  //   benefits: controller.argumentData.benefits,
  // ),
  //       )
  //     ],
  //   );
  // }
}
