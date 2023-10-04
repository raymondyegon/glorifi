import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class TileButtonWidget extends StatelessWidget {
  final bool inSnapshot;
  final String icon;
  final String title;
  final String? description;
  final VoidCallback callback;

  TileButtonWidget({
    Key? key,
    required this.callback,
    required this.icon,
    this.inSnapshot = false,
    required this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          border: inSnapshot
              ? Border(
                  top: BorderSide(width: 1, color: GlorifiColors.altoGrey),
                )
              : Border(),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 55,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: inSnapshot
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))
                : BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 24.h,
            left: 16.w,
            right: 24.w,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                color: GlorifiColors.textColor,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            style: captionBold14Primary(
                              color: GlorifiColors.midnightBlue,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        SvgPicture.asset(
                          'assets/icons/arrow_right.svg',
                        )
                      ]),
                      if (description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            description!,
                            style: captionRegular14Primary(),
                          ),
                        ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
