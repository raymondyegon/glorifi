import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class LoanTile extends StatelessWidget {
  const LoanTile({
    Key? key,
    required this.onTap,
    required this.status,
    required this.accountDetail,
    required this.loanType,
    required this.isActive,
  }) : super(key: key);

  final status, accountDetail, loanType;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loanType,
                    style: smallSemiBold16Primary(
                      color: GlorifiColors.cornflowerBlue,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Account " + loanType,
                    style: captionSemiBold14Primary(
                      color: GlorifiColors.ebonyBlue,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Started on " + accountDetail,
                    style: captionSemiBold14Primary(
                      color: GlorifiColors.denimBlue,
                    ),
                  )
                ],
              ),
              Text(
                status,
                style: isActive
                    ? headlineBold21Secondary(
                        color: GlorifiColors.bloodOrange,
                      )
                    : headlineBold21Secondary(
                        color: GlorifiColors.cornflowerBlue,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
