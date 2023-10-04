import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class FaqCategoryErrorState extends StatelessWidget {
  const FaqCategoryErrorState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'We can’t load FAQs at this time.',
      style: headlineRegular31Secondary(),
    ).paddingOnly(
      top: 200.h,
      right: 24.w,
      left: 24.w,
    );
  }
}
