import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/basic_card_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/basic_card_design_preview.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BasicCardDesign extends StatelessWidget {
  final BasicCardDesignModel basicCardDesign;

  const BasicCardDesign({required this.basicCardDesign, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          basicCardDesign.title,
          style: headlineBold26Primary(
            color: GlorifiColors.darkBlue,
          ),
        ).marginOnly(
          bottom: 36.h,
        ),
        ...List.generate(
          basicCardDesign.previewModel!.length,
          (index) => BasicCardDesignPreview(
                  img: basicCardDesign.previewModel![index].image!,
                  description:
                      basicCardDesign.previewModel![index].description!)
              .marginOnly(bottom: 50.h),
        )
      ],
    ).marginOnly(left: 24.w, right: 32.w);
  }
}
