import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/credit_limit_and_apr_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/model/credit_limit_view_model.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/widget/eligible_for_cash_advance.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class ViewCreditLimitAndAprScreen
    extends GetView<ViewCreditLimitAndAprController> {
  const ViewCreditLimitAndAprScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.white,
        appBar: GlorifiAppBar(
          title: "",
          elevation: 0,
          toolbarHeight: 20,
          disableLeading: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: Get.back,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Account Details",
                style: headlineRegular32Secondary(
                        color: GlorifiColors.midnightBlue)
                    .copyWith(fontWeight: FontWeight.w700),
              ).paddingOnly(bottom: 40.h),
              CreditLimitAndAprDetails(
                title: "Purchases",
                itemCount: 3,

                /// Pass the item data model from Controller
                item: CreditLimitModel(
                    creditLimit: 12000, apr: 12.99, availableCredit: 11849.36),
              ),

              /// Change the item view logic from controller
              /// based on API data
              if (controller.eligibleForCashAdvance.value)
                CreditLimitAndAprDetails(
                  title: "Eligible for Cash Advance",
                  itemCount: 3,

                  /// Pass the item data model from Controller
                  item: CreditLimitModel(
                      creditLimit: 12000,
                      apr: 12.99,
                      availableCredit: 11849.36),
                ).paddingOnly(top: 40.h),
            ],
          ),
        ),
      );
    });
  }
}
