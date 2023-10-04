import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tiles/expandable_two_line_tile/expandable_tile_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ExpandableTwoLineListTile extends GetWidget {
  ExpandableTwoLineListTile(
      {Key? key, this.title, this.subtitle, required this.child, this.leftPadding=24})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final Widget child;
  final double leftPadding;

  final ExpandableTileController controller =
      Get.put(ExpandableTileController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    if (title != null) {
      items.add(

        Text(
          title!,
          style: captionBold14Primary(color: GlorifiColors.midnightBlueColor),

        ),
      );
    }

    if (subtitle != null) {
      items.add(
        Text(
          subtitle!,
          style:smallRegular16Primary(color: GlorifiColors.midnightBlueColor).copyWith(
            height: 20 / 12,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 55,
            ),
          ],
        ),
        child: Obx(
          () => Column(
            children: [
              InkWell(
                onTap: controller.toggle,
                child: Container(
                  padding: EdgeInsets.only(left: leftPadding.w, right: 16.w),
                  height: 80.h,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items,
                        ),
                      ),
                      SizedBox(width: 20.h),
                      AnimatedRotation(
                        turns: controller.isExpanded.isTrue ?  0 : 0.5,
                        duration: Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          'assets/icons/chevron_up.svg',
                          color: GlorifiColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                alignment: Alignment.topCenter,
                duration: Duration(
                  milliseconds: 300,
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  height: controller.isExpanded.isTrue ? null : 0,
                  width: double.infinity,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
