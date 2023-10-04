import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/highlights/highlight_controller.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/types/base_highlight.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class StandardHighlight extends GetView<HighlightController> {
  final StandardHighlightModel highlight;

  const StandardHighlight(
      {Key? key, required StandardHighlightModel this.highlight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _addFormatting(Widget child) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10),
        width: .65.sw,
        child: child,
      );
    }

    return BaseHighlight(
        highlight: highlight,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 20.h, right: 10.h),
                  child: Image.asset(
                    'assets/images/Brand-Mark.png',
                    width: 40.w,
                  )),
              _addFormatting(Text(
                highlight.title + "\n",
                maxLines: 3,
                style: TextStyle(
                  color: GlorifiColors.darkBlue,
                  fontSize: 24.sp,
                ),
              )),
              _addFormatting(Row(
                children: [
                  Text(
                    highlight.callToAction,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'univers'),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.red,
                  ),
                ],
              ))
            ]));
  }
}
