import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/tabs.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class DepositedChecksScreen extends GetView<DepositedCheckController> {
  DepositedChecksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          title: 'Deposited Checks',
        ),
        body: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CheckTabSelector(
                    menuItems: controller.menuItems,
                    isSelected: controller.isSelected.value,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.menuItems.length,
                    onPageChanged: (value) =>
                        controller.currentPage.value = value,
                    itemBuilder: (context, index) => <Widget>[
                      _recentDeposited(),
                      _recentDeposited(),
                      _recentDeposited(),
                    ][index],
                  ),
                ),
              ],
            )));
  }

  Widget _recentDeposited() {
    return ListView(children: <Widget>[
      ...controller.items.map((value) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 8.h,
          ),
          child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.viewCheck, arguments: {
                  'backImage': value.back_image,
                  'frontImage': value.front_image
                });
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.date,
                            style: xSmallSemiBold12Primary(
                              color: GlorifiColors.dateDarkGrey,
                            ),
                          ),
                          Container(
                            height: 28.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                gradient: _buildStatusIcon(value.status)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.w, vertical: 4.h),
                              child: Text(
                                value.status.name,
                                style: xSmallSemiBold12Primary(
                                  color: GlorifiColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        value.description,
                        style: captionSemiBold14Primary(
                          color: GlorifiColors.ebonyBlue,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        value.number,
                        style: smallSemiBold16Primary(
                          color: GlorifiColors.biscayBlue,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        value.amount.formatCurrencyWithZero(),
                        style: leadBold24Secondary(
                          color: GlorifiColors.biscayBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      }).toList(),
    ]);
  }

  _buildStatusIcon(CheckStatus status) {
    switch (status) {
      case CheckStatus.Complete:
        {
          return RadialGradient(
            radius: 1.r,
            colors: [
              GlorifiColors.gradientLightGreen,
              GlorifiColors.gradientDarkGreen,
            ],
          );
        }
      case CheckStatus.Rejected:
        {
          return RadialGradient(
            radius: 1.r,
            colors: [
              GlorifiColors.lightRed,
              GlorifiColors.darkRed,
            ],
          );
        }
    }
  }
}
