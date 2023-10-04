import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/email_support_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class MsgField extends StatelessWidget {
  final String? name;
  final String? email;
  final String? phone;
  final String? category;
  final FocusNode? focusNode;
  final String? memberID;
  final AdaptiveSizingInfo sizingInfo;

  const MsgField({
    Key? key,
    this.name,
    this.email,
    this.phone,
    this.category,
    this.focusNode,
    this.memberID,
    required this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailSupportController>(
      init: EmailSupportController(),
      builder: (controller) {
        return Container(
          width: sizingInfo.isDesktop ? 848.w : Get.width,
          height: sizingInfo.isDesktop ? 222.h : 312.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
            border: Border.all(color: GlorifiColors.grey9E),
            color: GlorifiColors.white,
          ),
          child: Stack(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 11,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message',
                  hintStyle:
                      smallRegular16Primary(color: GlorifiColors.dateDarkGrey),
                  errorText: controller.error.value,
                  errorStyle:
                      captionRegular14Primary(color: GlorifiColors.lightRed),
                ),
                onChanged: (val) => controller.onChanged(val),
                controller: controller.messageController,
              ).paddingOnly(left: 10.w, right: 10.w).paddingOnly(bottom: 30.h),
              Positioned(
                bottom: 16.h,
                right: 16.h,
                child: GestureDetector(
                  onTap: () async {
                    String? strippedCat =
                        category!.toLowerCase().contains('general')
                            ? 'general'
                            : category;
                    await controller.submitMessage(
                        name, email, phone, memberID, strippedCat);
                  },
                  child: controller.pageState == PageState.DEFAULT
                      ? SvgPicture.asset(GlorifiAssets.sendMessage)
                      : GlorifiSpinner(size: 30.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
