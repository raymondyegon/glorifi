import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/cc_manage_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCManageReportCardScreen extends GetView<CCManageController> {
  const CCManageReportCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          elevation: 0,
          title: "Report Card",
          textStyle:
              headlineRegular21Secondary(color: GlorifiColors.midnightBlueColor)
                  .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w500),
          bgColor: GlorifiColors.white,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "File a report if your card is lost, stolen or compromised.",
                style: smallRegular16Primary(
                    color: GlorifiColors.defaultGradientStartColor),
              ).paddingOnly(bottom: 56),
              Text(
                "For your protection, we will deactivate your current card number.",
                style: smallRegular16Primary(
                    color: GlorifiColors.defaultGradientStartColor),
              ).paddingOnly(bottom: 25),
              Text(
                "You will be issued a new credit card number for use right away",
                style: smallRegular16Primary(
                    color: GlorifiColors.defaultGradientStartColor),
              ).paddingOnly(bottom: 25),
              Text(
                "Your physical card will be delivered within 7-10 days",
                style: smallRegular16Primary(
                    color: GlorifiColors.defaultGradientStartColor),
              ).paddingOnly(bottom: 25),
              Spacer(),
              PrimaryButton(
                title: "Report Card",
                primaryColor: GlorifiColors.midnightBlue,
                textColor: GlorifiColors.white,
                onTap: () {
                  Get.back(); // TODO: Implement Api
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
