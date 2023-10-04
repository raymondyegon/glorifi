import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class CCManageCardDataModel {
  final String text;
  final String leadingIcon;
  final bool isSwitch;

  CCManageCardDataModel(this.text, this.leadingIcon, this.isSwitch);

  String onTapValue() {
    if (leadingIcon == "lost_card") {
      return Routes.ccManageReportCardScreen;
    } else if (leadingIcon == "schedule") {
      return Routes.ccAutoPaymentInfoScreen;
    } else if (leadingIcon == "circular_info") {
      if (text == "FAQs and Support") {
        return Routes.faqCategoriesListingScreen;
      } else if (text == "View credit limit and APR") {
        return Routes.viewCreditLimitAndApr;
      }  else {
        return "POP";
      }
    } else {
      showSnackBar("Tapped on $text");
    }
    return "POP";
  }

  Widget getIcon() {
    if (leadingIcon == "lock") {
      return Icon(
        Icons.lock_outline,
        size: 24,
      );
    } else if (leadingIcon == "internet") {
      return SvgPicture.asset(
        'assets/icons/world.svg',
        width: 24,
        height: 24,
      );
    } else if (leadingIcon == "lost_card") {
      return SvgPicture.asset(
        'assets/icons/lost_card.svg',
        width: 24,
        height: 24,
      );
    } else if (leadingIcon == "schedule") {
      return SvgPicture.asset(
        'assets/icons/schedule.svg',
        width: 24,
        height: 24,
      );
    } else if (leadingIcon == "profile") {
      return SvgPicture.asset(
        'assets/icons/ic_profile_2.svg',
        width: 24,
        height: 24,
      );
    } else if (leadingIcon == "circular_info") {
      return SvgPicture.asset(
        'assets/icons/circular_info.svg',
        width: 24,
        height: 24,
      );
    }
    return SvgPicture.asset(
      'assets/icons/notes.svg',
      width: 24,
      height: 24,
    );
  }
}
