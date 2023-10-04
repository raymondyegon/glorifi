import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class SearchListItem extends StatelessWidget {
  final Function? onTap;
  final Widget label;
  final Color textColor;
  final double fontSize;

  const SearchListItem({
    Key? key,
    this.onTap,
    required this.label,
    this.textColor: GlorifiColors.black,
    this.fontSize: 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 8.h,
                ),
                margin: EdgeInsets.only(
                  right: 24.w,
                  bottom: 15.h,
                  top: 20.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  color: GlorifiColors.biscayBlue,
                ),
                child: SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  color: GlorifiColors.white,
                ),
              ),
              Expanded(
                flex: 7,
                child: label,
              ),
            ],
          ),
          Divider(
            color: GlorifiColors.greyBgColor,
          ),
        ],
      ),
    );
  }
}
