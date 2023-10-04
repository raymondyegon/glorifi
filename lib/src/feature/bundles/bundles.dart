import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/bundles/controller/bundle_controller.dart';
import 'package:glorifi/src/feature/bundles/widgets/bundle_details_loading_shimmer.dart';
import 'package:glorifi/src/feature/bundles/widgets/bundle_details_text_shimmer.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:intl/intl.dart';

class Bundles extends GetView<BundleController> {
  Bundles({Key? key}) : super(key: key);

  BundleController get controller =>
      Get.find<BundleController>(tag: BundleController.bundleScreenTag);

  final formatter =  NumberFormat("#,##0", "en_US");


  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.superLightGrey,
          appBar: GlorifiAppBar(
            title: "${controller.title.value} Bundle",
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0.w,
              vertical: 24.0.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: Image.asset(
                    controller.assetImage.value,
                    width: 1.sw,
                    fit: BoxFit.cover,
                  ),
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 180.h,
                        padding: EdgeInsets.only(
                          top: 20.h,
                          bottom: 24.h,
                          left: 24.h,
                          right: 24.h,
                        ),
                        decoration: BoxDecoration(
                          color: GlorifiColors.darkBlueTint[700],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getLogoRow("${controller.title.value} Bundle"),
                            SizedBox(height: 20.h),
                            Text(
                              "Earn points faster and save with a premium bundle package.",
                              style: headlineRegular21Secondary(
                                color: GlorifiColors.white,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 32.h),
                Text(
                  'Complete Your Bundle',
                  style: headlineBold21Secondary(
                    color: GlorifiColors.biscayBlue,
                  ),
                ).paddingOnly(bottom: 8.h),
                Obx(
                  () => controller.pageState == PageState.LOADING
                      ? BundleDetailsTextShimmer(
                          text: 'Earn points when you complete this bundle.',
                          textStyle: sansNormalStyle.copyWith(
                            color: GlorifiColors.black,
                          ),
                          baseColor: GlorifiColors.altoGrey,
                          highlightColor: GlorifiColors.greyBgColor.withOpacity(
                            0.3,
                          ),
                        )
                      : controller.bundleDetails.points != null
                          ? RichText(
                              text: TextSpan(
                                text: 'Earn ',
                                style: sansNormalStyle.copyWith(
                                  color: GlorifiColors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: formatter.format(controller.bundleDetails.points),
                                    style: sansNormalStyle.copyWith(
                                      fontSize: 21.sp,
                                      color: GlorifiColors.darkBlueColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' when you complete this bundle.',
                                    style: sansNormalStyle.copyWith(
                                      color: GlorifiColors.black,
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ).paddingOnly(bottom: 26.h)
                          : SizedBox(),
                ),
                Expanded(
                  flex: 0,
                  child: Obx(
                    () => controller.pageState == PageState.LOADING
                        ? Column(
                            children: [
                              ...List.generate(
                                3,
                                (index) => BundleDetailsLoadingShimmer(
                                  height: 64.h,
                                  baseColor: GlorifiColors.altoGrey,
                                  highlightColor: GlorifiColors.greyBgColor.withOpacity(
                                    0.3,
                                  ),
                                  rounded: true,
                                ).paddingSymmetric(
                                  vertical: 10.h,
                                ),
                              )
                            ],
                          )
                        : ListView.separated(
                      primary: false,
                            shrinkWrap: true,
                            itemCount: controller.bundleDetails.tasks?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.h,
                                  horizontal: 5.w,
                                ),
                                decoration: BoxDecoration(
                                  color: GlorifiColors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: GlorifiColors.black.withOpacity(0.10),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    controller.navigateToTask(index);
                                  },
                                  title: Text(
                                    controller.bundleDetails.tasks?[index].title ?? '',
                                    style: smallSemiBold16Primary(
                                      color: GlorifiColors.blueMidnightBlue,
                                    ),
                                  ),
                                  trailing: SvgPicture.asset(
                                    GlorifiAssets.arrowForward,
                                    height: 14.h,
                                    width: 16.w,
                                    color: GlorifiColors.darkGrey,
                                  ),
                                ),
                              );
                            },
                      separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 24.0.h);
                            },
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

  Widget _getLogoRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          GlorifiAssets.glorifiLogo,
          width: 27.w,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: captionSemiBold14Primary(
            color: GlorifiColors.white,
          ),
        ),
      ],
    );
  }
}
