import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/feature/atms/models/atm_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class AtmComponent extends StatelessWidget {
  final AtmModel data;

  final VoidCallback onTap;

  const AtmComponent({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: GlorifiColors.black.withOpacity(.10),
                blurRadius: 55,
                offset: Offset(0, 0),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  GlorifiAssets.atm,
                  width: 14.w,
                  height: 18.h,
                  color: GlorifiColors.darkBlue,
                ),
                SizedBox(width: 21.h),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: smallSemiBold16Primary(
                          color: GlorifiColors.cornflowerBlue,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        data.desc,
                        style: captionRegular14Primary(
                          color: GlorifiColors.matBlack,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
