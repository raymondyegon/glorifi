import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import '../../../widgets/simple_credit_card_benefits.dart';

class CCServices extends StatelessWidget {
  final List<String> benefits;

  const CCServices({required this.benefits, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 10.h,
          color: GlorifiColors.midnightBlue,
          height: 0,
        ),
        Container(
          padding:
              EdgeInsets.only(left: 24.w, right: 32.w, top: 50.h, bottom: 50.h),
          color: GlorifiColors.white,
          child: SimpleCreditCardBenefits(
            benefits: benefits,
          ),
        ),
        Divider(
          thickness: 10.h,
          color: GlorifiColors.midnightBlue,
          height: 0,
        ),
      ],
    );
  }
}
