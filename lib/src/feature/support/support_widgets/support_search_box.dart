import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import '../../../glorifi-widgets/glorifi_textformfield.dart';
import '../../../utils/constants.dart';

class SupportSearchBox extends StatelessWidget {
  late FAQCategoriesController controller;

  SupportSearchBox({Key? key}) : super(key: key) {
    controller = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.isBottomSheet) {
          controller.navigationStack.insert(0, FaqSearchScreen);
          controller.update();
        } else {
          Get.toNamed(Routes.searchFaqScreen);
        }
      },
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: GlorifiColors.black.withOpacity(0.10),
                spreadRadius: 0,
                blurRadius: 15.r,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: GlorifiTextFormField(
            hintText: 'Ask a question',
            prefixIcon:
                SvgPicture.asset('assets/icons/search_icon.svg').paddingOnly(
              left: 16.w,
              right: 16.w,
            ),
            textColor: GlorifiColors.textColorBlack,
            outlineBorderColor: GlorifiColors.greyBgColor.withOpacity(0.5),
            focusBorderColor: GlorifiColors.greyBgColor.withOpacity(0.2),
            enableBorderColor: GlorifiColors.greyBgColor.withOpacity(0.2),
            keyboardType: TextInputType.text,
            cursorColor: GlorifiColors.black,
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
