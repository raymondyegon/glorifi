import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class InsuranceTile extends StatelessWidget {
  const InsuranceTile({
    Key? key,
    required this.onTap,
    required this.status,
    required this.accountDetail,
    required this.loanType,
    required this.isActive,
    this.contentPadding,
    this.startDate,
  }) : super(key: key);

  final status, accountDetail, loanType;
  final String? startDate;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(
              thickness: 1,
              color: GlorifiColors.altoGrey,
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: contentPadding ?? EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loanType,
                        style: captionBold14Primary(
                          color: GlorifiColors.midnightBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        accountDetail,
                        style: captionRegular14Primary(
                          color: GlorifiColors.midnightBlue,
                        ).copyWith(height: 1.4),
                      ),
                      if (startDate != null)
                        Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(startDate!,
                                style: captionRegular14Primary(
                                  color: GlorifiColors.midnightBlue,
                                )),
                          ],
                        )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: GlorifiColors.cornflowerBlue,
                        borderRadius: BorderRadius.circular(8.r)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          status,
                          style: xSmallBold12Primary(
                            color: GlorifiColors.white,
                          ),
                        ),
                        isActive
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                    GlorifiAssets.arrowForward,
                                    color: GlorifiColors.selectedIndicatorColor,
                                    height: 8,
                                    width: 8,
                                  )
                                ],
                              )
                            : Offstage()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
