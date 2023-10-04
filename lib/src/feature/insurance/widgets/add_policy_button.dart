import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AddPolicyButton extends StatelessWidget {
  const AddPolicyButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            GlorifiAssets.gridAddIcon,
            width: 22.w,
            height: 22.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "Add New Policy",
            style: smallSemiBold16Primary(color: GlorifiColors.midnightBlue),
          )
        ],
      ),
    );
    ;
  }
}
