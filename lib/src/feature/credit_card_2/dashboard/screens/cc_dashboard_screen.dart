import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/widgets/cc_carousel.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/widgets/cc_transactions.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CCDashboardScreen extends GetView<CCDashboardController> {
  const CCDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      Get.put(
          CCDashboardController(
          accountModel: Get.arguments['accountModel'],
          isMockEnabled: Get.arguments['isMockEnabled']));
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
          appBar: GlorifiAppBar(
            elevation: 0,
            title: controller.accountModel.cardName,
            textStyle: TextStyle(
                color: GlorifiColors.darkBlueColor,
                fontSize: 14,
                fontWeight: FontWeight.w700),
            toolbarHeight: 300,
            bgColor: GlorifiColors.bgColor.withOpacity(0.2),
          ),
          body:
              // Obx(() => controller.accountModel.type == ""
              // ? Center(child: GlorifiSpinner())
              // :
              SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          GlorifiColors.bgColor.withOpacity(0.2),
                          GlorifiColors.bgColor
                        ],
                      )),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _content()))));
    });
  }

  List<Widget> _content() {
    final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: r'$');
    final formatCurrencyNoDigits =
        NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 0);

    return [
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          ClipRect(
              child: Container(
                  height: 200,
                  child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.4,
                      child: CachedNetworkImage(
                        imageUrl: controller.accountModel.cardImageUrl,
                        // fit: BoxFit.fitWidth,
                        placeholder: (context, url) => SizedBox(
                            width: 0.85.sw, child: ShimmeryPlaceHolder()),
                        errorWidget: (context, url, error) => SizedBox(
                            width: 0.85.sw, child: ShimmeryPlaceHolder()),
                      )))).paddingOnly(right: 20),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Balance",
                  style: TextStyle(color: GlorifiColors.spanishGray),
                ),
                Wrap(children: [
                  Text(
                    "\$",
                    style: TextStyle(
                        fontSize: 24,
                        height: 1.5,
                        fontFamily: "Univers",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    controller.accountModel.currentBalance.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: "UniversWide",
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                SizedBox(
                  height: 45,
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.all(0),
                  width: 1.sw - 165,
                  lineHeight: 8.0,
                  percent: controller.accountModel.percent < 0.05
                      ? 0.05
                      : controller.accountModel.percent,
                  barRadius: Radius.circular(10),
                  backgroundColor: GlorifiColors.darkBlueColor.withOpacity(0.3),
                  progressColor: GlorifiColors.darkBlueColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(children: [
                  Text(
                    controller.accountModel.creditUtilization,
                    style: TextStyle(color: GlorifiColors.black),
                  ),
                  Text(
                    " credit utilization",
                    style: TextStyle(color: GlorifiColors.grey9E),
                  )
                ]).paddingOnly(bottom: 10),
                Wrap(children: [
                  Text(
                      "${formatCurrencyNoDigits.format(controller.accountModel.availableCredit.floor())} "),
                  Text(
                    "available credit",
                    style: TextStyle(color: GlorifiColors.grey9E),
                  )
                ]).paddingOnly(bottom: 25),
              ]),
        ],
      ).paddingOnly(bottom: 10),
      Wrap(children: [
        Text(
            "${formatCurrency.format(controller.accountModel.remainingStatementBalance)} "),
        Text(
          "Last Statement Balance",
          style: TextStyle(color: GlorifiColors.grey9E),
        )
      ]).paddingOnly(left: 20, bottom: 20, top: 10),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (controller.accountModel.autoPay != null)
            Column(
              children: [
                Text(
                  "Auto pay",
                  style: TextStyle(color: GlorifiColors.matBlack),
                ).paddingOnly(bottom: 5),
                Text(
                  DateFormat('MMM d').format(controller.accountModel.autoPay!),
                  style: TextStyle(
                      color: GlorifiColors.darkBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          Column(
            children: [
              Wrap(children: [
                Text("Due in ", style: TextStyle(color: GlorifiColors.matBlack))
                    .paddingOnly(bottom: 5),
                Text(
                  "${controller.daysUntilBillDue} days",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]),
              Text(DateFormat('MMM d').format(controller.accountModel.dueDate),
                  style: TextStyle(
                      color: GlorifiColors.darkBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700))
            ],
          ),
          Column(
            children: [
              Text("Minimum Due",
                      style: TextStyle(color: GlorifiColors.matBlack))
                  .paddingOnly(bottom: 5),
              Text(
                  formatCurrency.format(
                      controller.accountModel.remainingMinimumPaymentDue),
                  style: TextStyle(
                      color: GlorifiColors.darkBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700))
            ],
          )
        ],
      ).paddingSymmetric(vertical: 10),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _square("Payment", "assets/images/glorifi_logo/dollar_circle.svg",
              () {
            Get.toNamed(Routes.ccPayments,
                arguments: {"accountModel": controller.accountModel});
          }),
          _square("Statements", "assets/images/paper.svg", () {}),
          _square("Manage", "assets/images/glorifi_logo/grid_dots.svg", () {
            Get.toNamed(Routes.ccManage);
          })
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 20),
      SizedBox(
        height: 20,
      ),
      CCDashboardCarousel(),
      SizedBox(
        height: 30,
      ),
      CCDashboardTransactions(),
    ];
  }

  Widget _square(title, icon, onTap) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 0.25.sw,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadowField,
            color: GlorifiColors.white,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(icon).paddingOnly(bottom: 5),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            )
          ]),
        ));
  }
}
