import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AccountItem extends StatelessWidget {
  final GloriFiAccountData data;
  final VoidCallback onTap;

  const AccountItem({
    required this.data,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 16.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0.r),
              color: GlorifiColors.primaryButtonProgressColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.getType(),
                    style:
                        smallRegular16PrimaryBold(color: GlorifiColors.white),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    data.getMaskedNumber(),
                    style: smallRegular16Primary(color: GlorifiColors.white),
                  ),
                ],
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Available Balance\n',
                    style: xSmallRegular12Primary(
                      color: GlorifiColors.white,
                    ),
                    children: [
                      TextSpan(
                        text: data.getCurrentBalance(),
                        style: headlineBold31Secondary(
                          color: GlorifiColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
