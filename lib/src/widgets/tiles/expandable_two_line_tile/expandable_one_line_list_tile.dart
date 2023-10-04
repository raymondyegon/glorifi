import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tiles/expandable_two_line_tile/expandable_tile_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ExpandableOneLineListTile extends GetWidget {
  ExpandableOneLineListTile(
      {Key? key, this.title,   required this.child})
      : super(key: key);

  final String? title;
   final Widget child;

  final ExpandableTileController controller =
      Get.put(ExpandableTileController(), tag: UniqueKey().toString());

  // ignore: todo
  //TODO apply glorifi ui kit
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    if (title != null) {
      items.add(Text(
        title!,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: GlorifiColors.midnightBlueColor ,
          height: 1.33,
        ),
      ));
    }


    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  height: 56.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items,
                        ),
                      ),
                      SizedBox(width: 20),
                      AnimatedRotation(
                        turns: controller.isExpanded.isTrue ? 0 : 0.5,
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
