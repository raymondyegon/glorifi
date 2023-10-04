import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CloseModalButton extends StatelessWidget {
  final Function? onTap;

  const CloseModalButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 40.h),
      child: IconButton(
        icon: Container(
          height: 32.w,
          width: 32.w,
          decoration: BoxDecoration(
            color: GlorifiColors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              GlorifiAssets.chevronDown,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        tooltip: 'Close modal',
        onPressed: () {
          onTap?.call();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
