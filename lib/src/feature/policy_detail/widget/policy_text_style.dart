import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../utils/glorifi_colors.dart';

class PolicyTextStyle {
  static TextStyle? textStyleAddress = TextStyle(
    color: GlorifiColors.creditBgGrey,
    fontFamily: 'univers',
    fontWeight: FontWeight.bold,
    fontSize: 14.sp,
  );
  static TextStyle? textStyleAddressData = TextStyle(
    color: GlorifiColors.biscayBlue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static TextStyle? textStylePolicy = TextStyle(
    color: GlorifiColors.cornflowerBlue,
    fontFamily: 'univers',
    fontWeight: FontWeight.normal,
    fontSize: 21.sp,
  );
  static TextStyle? textStylePolicyDetail = TextStyle(
    color: GlorifiColors.cornflowerBlue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
  );
  static TextStyle? textStylePolicyHeading = TextStyle(
    color: GlorifiColors.cornflowerBlue,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );
}
