import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../model/MenuUiModel.dart';
import 'sub_menu_item.dart';

class MenuItemExpanded extends StatelessWidget {
  final MenuUiModel data;

  const MenuItemExpanded({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.cornflowerBlue,
      padding:
          EdgeInsets.only(left: 15.w, right: 27.w, top: 24.h, bottom: 24.h),
      child: Column(
        children: [
          InkWell(
            child: Row(children: [
              SvgPicture.asset(data.iconPath,
                  width: 22.w, height: 22.h, color: GlorifiColors.white),
              SizedBox(width: 16.w),
              Text(
                data.title,
                style: bodySemiBold18Primary(color: GlorifiColors.white),
              ),
              Spacer(),
              if (data.subMenuList.length > 0)
                SvgPicture.asset(GlorifiAssets.minus,
                    width: 22.w, height: 22.h, color: GlorifiColors.white),
            ]),
            onTap: () => data.isExpanded.value = false,
          ),
          SubMenuItem(dataList: data.subMenuList)
        ],
      ),
    );
  }
}
