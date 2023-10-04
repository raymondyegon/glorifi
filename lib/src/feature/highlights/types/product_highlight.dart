import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/highlights/highlight_controller.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/types/base_highlight.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class ProductHighlight extends GetView<HighlightController> {
  final StandardHighlightModel highlight;
  const ProductHighlight(
      {Key? key, required StandardHighlightModel this.highlight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseHighlight(
        highlight: highlight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 50.h)),
            Image.asset(
              'assets/images/logo.png',
              width: 40.w,
            ),
            Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  highlight.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10),
              height: 50.h,
              width: .65.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Text(
                highlight.callToAction,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'univers'),
              ),
            ),
          ],
        ));
  }
}
