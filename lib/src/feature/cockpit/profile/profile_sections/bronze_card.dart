import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../font_style_global.dart';

class BronzeCard extends StatelessWidget {
  const BronzeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 204.h,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Status',
              style: headlineRegular26Secondary(
                color: GlorifiColors.darkBlue,
              ),
            ),
            // Two Lines with Star in Between
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70.w,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: GlorifiColors.darkBlue,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.star,
                    color: GlorifiColors.darkBlue,
                  ),
                ),
                Container(
                  width: 70.w,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: GlorifiColors.darkBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              "BRONZE",
              style: displayBold64Secondary(
                color: Color(0xFF9F9263),
              ),
            ),
            Text(
              "Member",
              style: headlineRegular26Secondary(
                color: GlorifiColors.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
