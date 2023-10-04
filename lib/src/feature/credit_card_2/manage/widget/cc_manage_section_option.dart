import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/cc_manage_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/model/cc_manage_card_data_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CCManageSectionOption extends StatelessWidget {
  CCManageSectionOption({
    required this.itemCount,
    required this.item,
    Key? key,
  }) : super(key: key);

  final int itemCount;
  final List<dynamic> item;

  @override
  Widget build(BuildContext context) {
    CCManageController controller = Get.find();

    return Container(
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          if (!item[index].isSwitch) {
            return _buildTogglableOption(index);
          }
          return _buildOption(index, controller);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            height: 1,
            child: Divider(),
          );
        },
      ),
    );
  }

  Widget _buildOption(int index, CCManageController controller) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          item[index].getIcon(),
          SizedBox(width: 28),
          Container(
            width: 200,
            child: Text(
              item[index].text,
              maxLines: 2,
              style: captionSemiBold14Primary(
                color: GlorifiColors.darkBlue,
              ),
            ),
          ),
          Spacer(),
          Obx(
            () => FlutterSwitch(
              width: 36.0,
              height: 20.0,
              toggleSize: 12.0,
              activeColor: GlorifiColors.midnightBlue,
              value: controller.switchValue[index],
              onToggle: (val) {
                controller.changeSwitch(val, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTogglableOption(int index) {
    return InkWell(
      onTap: () {
        String routeName = item[index].onTapValue();
        if (routeName == "POP") {
          Get.back();
        } else {
          Get.toNamed(routeName);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            item[index].getIcon(),
            SizedBox(width: 28),
            Container(
              width: 200,
              child: Text(
                item[index].text,
                maxLines: 2,
                style: captionSemiBold14Primary(color: GlorifiColors.darkBlue),
              ),
            ),
            Spacer(),
            Icon(
              Icons.chevron_right,
              color: GlorifiColors.darkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
