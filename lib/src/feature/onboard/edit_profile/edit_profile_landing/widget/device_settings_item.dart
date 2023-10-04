import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class DeviceSettingsItem extends StatelessWidget {
  final String settingName;
  final bool status;
  final Function()? onTap;

  const DeviceSettingsItem({
    Key? key,
    required this.settingName,
    this.status = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusText = status ? "On" : "Off";
    return Ripple(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    settingName,
                    style: smallRegular16Primary(
                        color: GlorifiColors.midnightBlue),
                  ),
                ),
                Text(
                  statusText,
                  style: smallRegular16Primary(color: GlorifiColors.doveGray),
                ),
                SizedBox(width: 9.w),
                status
                    ? Container(
                        height: 12.h,
                        width: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GlorifiColors.lightGreenProfile,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            height: 1.h,
            color: GlorifiColors.silver,
          )
        ],
      ),
    );
  }
}
