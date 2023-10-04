import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CantFIndWidget extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final TextStyle textStyle;
  final bool isDesktop;

  const CantFIndWidget({
    Key? key,
    required this.textStyle,
    this.onTap,
    this.label,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.12,
        color: GlorifiColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 200.w:24.w,
        ).copyWith(
          top: isDesktop ? 34.h : 16.h,
          bottom: isDesktop ? 34.h : 32.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                label!,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: textStyle,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: GlorifiColors.darkBlue,
              size: isDesktop ? 18 : 24,
            ),
          ],
        ),
      ),
    );
  }
}
