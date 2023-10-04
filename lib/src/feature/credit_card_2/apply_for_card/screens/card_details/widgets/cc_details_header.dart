import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/card_details.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CCDetailsScreenHeader extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final String desc;
  final Color bgColor;
  final Color backButtonBorderColor;
  final Color textBgColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color desColor;

  CCDetailsScreenHeader({
    required this.img,
    required this.title,
    required this.subTitle,
    required this.desc,
    this.bgColor = GlorifiColors.midnightBlue,
    this.backButtonBorderColor = GlorifiColors.white,
    this.textBgColor = GlorifiColors.midnightBlue,
    this.titleColor = GlorifiColors.white,
    this.subTitleColor = GlorifiColors.white,
    this.desColor = GlorifiColors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15.w, top: kToolbarHeight + 24.h),
            child: InkWell(child: SvgPicture.asset(GlorifiAssets.cta_back),
              onTap: Get.back,)
          ),
          Container(
            padding: EdgeInsets.only(top: 60.h, bottom: 85.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 29.w),
                  child: Transform(
                    alignment: FractionalOffset.center,
                    transform: transformMatrix,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        img,
                        height: 258.h,
                        width: 412.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                CardDetails(
                  title: title,
                  titleColor: titleColor,
                  subTitle: subTitle,
                  subTitleColor: subTitleColor,
                  desc: desc,
                  desColor: desColor,
                  bgColor: textBgColor,
                ).marginOnly(top: 100.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Matrix4 transformMatrix = Matrix4(
    1.1,
    -.5,
    0,
    0,
    0.7,
    0.84,
    0,
    0,
    0,
    0,
    1,
    0,
    110,
    0,
    0,
    1,
  );
}
