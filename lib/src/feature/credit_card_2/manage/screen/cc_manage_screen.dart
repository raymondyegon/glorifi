import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/cc_manage_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/widget/cc_manage_section_option.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/widget/cc_manage_detail_title_text.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class CCManageScreen extends GetView<CCManageController> {
  const CCManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: GlorifiAppBar(
          elevation: 0,
          title: "Manage",
          textStyle: bodyBold18Secondary(color: GlorifiColors.midnightBlue),
          bgColor: GlorifiColors.bgColor,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CCManageSectionHeader(text: "Security"),
              CCManageSectionOption(
                itemCount: controller.security.length,
                item: controller.security,
              ),
              CCManageSectionHeader(text: "Payment"),
              CCManageSectionOption(
                itemCount: controller.payment.length,
                item: controller.payment,
              ),
              CCManageSectionHeader(text: "Account"),
              CCManageSectionOption(
                itemCount: controller.account.length,
                item: controller.account,
              ),
              CCManageSectionHeader(text: "Help"),
              CCManageSectionOption(
                itemCount: controller.help.length,
                item: controller.help,
              ),
              CCManageSectionHeader(text: "Account Documents"),
              CCManageSectionOption(
                itemCount: controller.accountDocuments.length,
                item: controller.accountDocuments,
              ),
              CCManageSectionHeader(text: "Legal Documents"),
              CCManageSectionOption(
                itemCount: controller.legalDocuments.length,
                item: controller.legalDocuments,
              ),
              SizedBox(height: 64)
            ],
          ),
        ),
      );
    });
  }
}
