import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/insurance/model/roadside_assistance_data.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class RoadsideContentTile extends StatelessWidget {
  const RoadsideContentTile({Key? key, required this.roadsideAssistanceData})
      : super(key: key);

  final RoadsideAssistanceData roadsideAssistanceData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            roadsideAssistanceData.image,
            height: 24,
            width: 24,
            color: GlorifiColors.denimBlue,
          ),
          SizedBox(
            width: 14.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roadsideAssistanceData.title,
                  style: bodyBold18Primary(color: GlorifiColors.denimBlue),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  roadsideAssistanceData.content,
                  style: smallRegular16Primary(color: GlorifiColors.ebonyBlue),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
