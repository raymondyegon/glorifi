import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../model/MenuUiModel.dart';

class MenuItemCollapsed extends StatelessWidget {
  final MenuUiModel data;

  MenuItemCollapsed({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding:
            EdgeInsets.only(left: 15.w, right: 27.w, top: 24.h, bottom: 24.h),
        child: Row(children: [
          SvgPicture.asset(data.iconPath,
              width: 22.w, height: 22.h, color: GlorifiColors.darkGrey80),
          SizedBox(width: 16.w),
          Text(
            data.title,
            style: bodySemiBold18Primary(color: GlorifiColors.darkGrey80),
          ),
          Spacer(),
          if (data.subMenuList.length > 0)
            SvgPicture.asset(GlorifiAssets.plus,
                width: 22.w, height: 22.h, color: GlorifiColors.darkGrey80),
        ]),
      ),
      onTap: () => data.isExpanded.value = true,
    );
  }
}
