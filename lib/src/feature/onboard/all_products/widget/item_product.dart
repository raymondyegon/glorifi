import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/all_products/model/product_ui_model.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_button.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';

class ItemProduct extends StatelessWidget {
  final ProductUiModel data;
  final Function()? onTap;

  ItemProduct({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 1.6,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(data.backgroundImagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(child: GradientOverlayContainer(child: Container())),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _getDescriptionBody(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _getDescriptionBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            data.title,
            style: TextStyle(
                color: GlorifiColors.lightBlue,
                fontWeight: FontWeight.w400,
                fontFamily: 'univers',
                fontSize: 31),
          ),
          const SizedBox(height: 5),
          Text(
            data.description,
            style: TextStyle(
              color: GlorifiColors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          profileNextButton(
            context,
            "Get Started",
            Icon(
              Icons.arrow_forward,
              color: GlorifiColors.selectedIndicatorColor,
            ),
            onTap!,
            primaryColor: GlorifiColors.white,
            textColor: GlorifiColors.midnightBlueColor,
            splashColor: GlorifiColors.midnightBlueColor,
            fontSize: 18,
          )
        ],
      ).marginOnly(left: 8, right: 8, bottom: 16),
    );
  }
}
