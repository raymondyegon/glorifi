import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';
import '../../../utils/glorifi_colors.dart';

class MortgageDetailTile extends StatelessWidget {
  const MortgageDetailTile(
      {Key? key, required this.firstHeading, required this.firstData})
      : super(key: key);

  final String firstHeading, firstData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    firstHeading,
                    style: captionBold14Secondary(
                      color: GlorifiColors.creditBgGrey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.r),
                    child: Text(
                      firstData,
                      style: captionSemiBold14Primary(
                        color: GlorifiColors.biscayBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
