import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/compare/compare_value.dart';
import 'package:glorifi/src/feature/personal_snapshot/compare/compare_value_dialog.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsBgWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                      headerTitle: "My Banking",
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : sizingInfo.isWebMobile
                                  ? 24.5.w
                                  : 23.75.w),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1024),
                    child: AdaptiveGrid(
                      children: [
                        AdaptiveGridItem(
                          desktop: 40,
                          tablet: 100,
                          webMobile: 100,
                          nativeMobile: 100,
                          child: Container(
                            child: glorifiButton(
                                text: 'Open Comparison',
                                onTap: () => {
                                      if (sizingInfo.isNativeMobile ||
                                          sizingInfo.isWebMobile)
                                        {
                                          Get.bottomSheet(
                                            CompareValueScreen(
                                              gloriFiCompareState:
                                                  GloriFiCompareType.homeValue,
                                              member: '1.612.000',
                                            ),
                                            barrierColor:
                                                GlorifiColors.barrierColor,
                                            isScrollControlled: true,
                                            isDismissible: false,
                                          ),
                                        }
                                      else
                                        {
                                          Get.defaultDialog(
                                            backgroundColor: Colors.transparent,
                                            title: '',
                                            content: CompareValueDialog(
                                                gloriFiCompareState:
                                                    GloriFiCompareType
                                                        .homeValue,
                                                member: '1.612.000',

                                                //TODO compare value from card id
                                                cardId: 6),
                                            radius: 5.r,
                                          ),
                                        }
                                    }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
