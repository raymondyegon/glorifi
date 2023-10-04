import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../../utils/glorifi_assets.dart';
import '../../../utils/login_status/login_status.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';
import 'search_content.dart';

class FaqSearchScreen extends StatelessWidget {
  List libraryIDs = [];
  late FAQCategoriesController supportMainController;
  bool? isBottomSheet;


  FaqSearchScreen({Key? key, this.isBottomSheet}) : super(key: key) {
    supportMainController = Get.find<FAQCategoriesController>();
    libraryIDs = supportMainController.getLibraryIDs();
  }

  @override
  Widget build(BuildContext context) {
    if (libraryIDs.isEmpty) {
      libraryIDs = supportMainController.getLibraryIDs();
    }
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: isBottomSheet == null,
      backgroundColor: GlorifiColors.lightWhite,
      showSimpleAppBar: !supportMainController.isLoggedIn,
      appBar: GlorifiAppBar(
        elevation: 5,
        title: 'Search',
        textStyle: bodySemiBold18Primary(
          color: GlorifiColors.midnightBlueColor,
        ),
        leading: Leading(
          icon: IconButton(
            icon: SvgPicture.asset(
              GlorifiAssets.careLeftSmall,
            ),
            onPressed: () {
              if (supportMainController.isBottomSheet) {
                supportMainController.navigationStack.removeAt(0);
                supportMainController.update();
              } else {
                Get.back();
              }
            },
          ),
        ),
        trailing: Trailing(
          text: 'Close',
          textStyle: captionBold14Primary(color: GlorifiColors.darkOrange),
          onTap: () {
            supportMainController.isBottomSheet
                ? Get.back()
                : Get.until(
                    (route) => !Get.currentRoute.contains('faq'),
                  );
          },
        ),
      ),
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                    headerTitle: 'Search',
                    showWebPageFont: true,
                    horizontalPadding: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isTablet
                            ? 34.5.w
                            : sizingInfo.isWebMobile
                                ? 24.5.w
                                : 23.75.w,
                    showTrailingButton: false,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizingInfo.isDesktop
                        ? 260.w
                        : sizingInfo.isTablet
                            ? 34.5.w
                            : 0.0.w,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1024,
                    ),
                    child: AdaptiveGrid(
                      children: [
                        AdaptiveGridItem(
                          desktop: 100,
                          tablet: 100,
                          nativeMobile: 100,
                          webMobile: 100,
                          child: SearchContent(
                            sizingInfo: sizingInfo,
                            libraryIDs: libraryIDs,
                          ).paddingOnly(
                            top: sizingInfo.isWebMobile
                                ? 23.h
                                : sizingInfo.isNativeMobile
                                    ? 23.h
                                    : 25.h,
                            right: 24.w,
                            left: 24.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
