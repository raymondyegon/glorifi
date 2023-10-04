import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/personal_snapshot_constants.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/detail_screen_layout_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/tile_button_widget.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/appbars/glorifi_appbar.dart';
import '../../../widgets/tiles/expandable_two_line_tile/expandable_one_line_list_tile.dart';

class HomeValueDetailsScreen extends GetView<HomeValueController> {
  HomeValueDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgBoxColor,
        appBar: GlorifiAppBar(
          title: 'Home Value',
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.ebonyBlue,
          ),
        ),
        body: DetailScreen(sizingInfo: sizingInfo),
      );
    });
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.sizingInfo,
  }) : super(key: key);

  final sizingInfo;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeValueController>();
    final asOfDate = controller.homeValueDetail.value.asOfDate != null
        ? controller.homeValueDetail.value.asOfDate
        : DateTime.now();
    return Obx(
      () => DetailScreenLayoutWidget(
        isLoading: controller.fetchingAddressData.value,
        isNoFound: true,
        refresh: controller.onInit,
        title: "Home Value",
        headerText: controller.homeValueDetail.value.description,
        mainValue: controller.homeValueDetail.value.value,
        statusApi: controller.statusApi.value,
        chart: Padding(
          padding: EdgeInsets.only(top: 56.h, bottom: 84.h),
          child: LineChartWidget(
            data: controller.homeValueDetail.value.historical,
          ),
        ),
        lastPullInfo: 'As of ${asOfDate?.todMMM()} (pull $kHomeValuePullRate)',
        dataSourceLabel: "",
        bottomContent: [
          Visibility(
            visible: true,
            child: TileButtonWidget(
              title: "Compare Home Value",
              callback: () {
                controller.openComparison(
                    sizingInfo.isNativeMobile || sizingInfo.isWebMobile);
              },
              icon: 'assets/icons/home_icon.svg',
            ),
          ),
          SizedBox(height: 24.h),
          controller.fetchingAddressData.isTrue
              ? CardClean()
              : controller.primaryAddress.isTrue
                  ? PrimaryAddressCard(
                      mainValue: controller.homeValueDetail.value.value,
                    )
                  : AddAdress(),
        ],
      ),
    );
  }
}

class AddAdress extends StatelessWidget {
  const AddAdress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeValueController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'To see your Home Value, you have to enter your home address below:',
          style: smallRegular16Secondary(
            color: GlorifiColors.textColor,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: () => {
            controller.goToAddressScreen(AddressFlowType.add),
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add My Home Address',
                  style: smallRegular16Secondary(
                    color: GlorifiColors.textColor,
                  ),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: GlorifiColors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardClean extends StatelessWidget {
  const CardClean({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: Shimmer.fromColors(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SizedBox.expand(),
        ),
        baseColor: GlorifiColors.altoGrey,
        highlightColor: Colors.white,
      ),
    );
  }
}

class PrimaryAddressCard extends StatelessWidget {
  PrimaryAddressCard({
    this.mainValue,
    Key? key,
  }) : super(key: key);

  final double? mainValue;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeValueController>();
    return ExpandableOneLineListTile(
      title: 'Primary Address',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, color: GlorifiColors.bgBoxColor),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 20.0.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.streetAddress.value.trim(),
                        style: captionBold14Primary(
                          color: GlorifiColors.textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(
                      () => Text(
                        controller.cityState.value.trim(),
                        style: captionRegular14Primary(
                          color: GlorifiColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (mainValue == null)
                  SvgPicture.asset(
                    GlorifiAssets.alertCircle,
                    color: GlorifiColors.redError,
                    width: 24.w,
                    height: 24.h,
                  ),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => {
              controller.goToEditAddressScreen(),
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'Edit',
                style: captionSemiBold14Primary(color: GlorifiColors.textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
