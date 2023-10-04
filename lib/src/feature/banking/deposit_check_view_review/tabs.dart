import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CheckTabSelector extends GetView<DepositedCheckController> {
  const CheckTabSelector({
    Key? key,
    required this.menuItems,
    required this.isSelected,
  }) : super(key: key);
  final List<String> menuItems;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 45.h,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: menuItems
              .map((_menuItem) => _tabItem(
                    menuItems.indexOf(_menuItem) ==
                        controller.currentPage.value,
                    _menuItem,
                    () {
                      controller.currentPage.value =
                          menuItems.indexOf(_menuItem);
                      controller.pageController.animateToPage(
                        controller.currentPage.value,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _tabItem(bool isSelected, String text, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              text,
              style: smallBold16Secondary(
                color: isSelected
                    ? GlorifiColors.darkBlue
                    : GlorifiColors.greyBgColor,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 5.h,
              color: isSelected
                  ? GlorifiColors.darkBlue
                  : GlorifiColors.greyBgColor,
            ),
          ],
        ),
      ),
    );
  }
}
