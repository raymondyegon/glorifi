import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class PendingDataWidget extends StatelessWidget {
  const PendingDataWidget({
    Key? key,
    required this.onExpandClick,
    required this.isExpanded,
    this.pendingCount,
    required this.widgetList,
    required this.title,
    this.count = 0,
    this.button,
  }) : super(key: key);

  final String title;
  final String? pendingCount;
  final VoidCallback onExpandClick;
  final bool isExpanded;
  final int count;
  final List<Widget> widgetList;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      color: GlorifiColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: bodyRegular18Secondary(
                        color: GlorifiColors.cornflowerBlue,
                      ),
                    ),
                  ),
                  if (pendingCount != null)
                    Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(pendingCount!, style: captionBold14Primary())
                      ],
                    )
                ],
              ),
              InkWell(
                onTap: onExpandClick,
                child: Visibility(
                  visible: count == 0 ? false : true,
                  child: Ink(
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      color: GlorifiColors.bloodOrange,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: count == 0
                ? true
                : isExpanded
                    ? false
                    : true,
            child: Column(
              children: [
                SizedBox(
                  height: 9.h,
                ),
                Divider(
                  thickness: 1,
                  color: GlorifiColors.altoGrey,
                ),
              ],
            ),
          ),
          isExpanded && count > 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Column(children: widgetList),
                    SizedBox(
                      height: 16.h,
                    ),
                    Divider(
                      thickness: 1,
                      color: GlorifiColors.altoGrey,
                    ),
                  ],
                )
              : Offstage(),
          if (button != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22.h,
                ),
                button!,
              ],
            )
        ],
      ),
    );
  }
}
