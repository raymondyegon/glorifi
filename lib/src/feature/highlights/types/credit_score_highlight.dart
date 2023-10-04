import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/types/base_highlight.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CreditScoreHighlight extends StatelessWidget {
  final CreditScoreHighlightModel highlight;

  const CreditScoreHighlight(
      {Key? key, required CreditScoreHighlightModel this.highlight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseHighlight(
      highlight: highlight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            highlight.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(highlight.score.toString(),
                    style: TextStyle(
                      fontFamily: 'univers',
                      fontSize: 36.sp,
                      color: Colors.white,
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(highlight.points.toString() + "+",
                        style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              "TODO:",
              // "updated: " + highlight. + " ago",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
