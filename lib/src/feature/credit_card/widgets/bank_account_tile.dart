import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class BankAccountTile extends StatelessWidget {
  const BankAccountTile(
      {Key? key,
      required this.onTap,
      required this.balance,
      required this.secretNumber,
      required this.bankName,
      required this.accountType})
      : super(key: key);

  final balance, secretNumber, bankName, accountType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: GlorifiColors.white,
            borderRadius: BorderRadius.circular(8.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankName,
                      style: smallSemiBold16Primary(
                        color: GlorifiColors.cornflowerBlue,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          accountType,
                          style: captionRegular14Primary(
                            color: GlorifiColors.denimBlue,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "|",
                          style: captionRegular14Primary(
                            color: GlorifiColors.denimBlue,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "*" + secretNumber,
                          style: captionRegular14Primary(
                            color: GlorifiColors.denimBlue,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Text(
                balance,
                style: headlineBold21SecondarySans(
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
