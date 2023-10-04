import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class SubMenuItem extends StatelessWidget {
  final List<String> dataList;

  const SubMenuItem({required this.dataList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 38.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                ...List.generate(dataList.length, (index) {
                  return InkWell(
                    child: Column(
                      children: [
                        SizedBox(height: 14.h),
                        Text(
                          dataList[index],
                          style:
                              smallRegular16Primary(color: GlorifiColors.white),
                        ),
                      ],
                    ),
                    onTap: () {},
                  );
                })
              ],
            ),
          ],
        ));
  }
}
