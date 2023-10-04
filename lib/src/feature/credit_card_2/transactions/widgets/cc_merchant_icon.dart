import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CCMerchantIcon extends StatelessWidget {
  const CCMerchantIcon({Key? key, required this.icon}) : super(key: key);

  final String? icon;

  @override
  Widget build(BuildContext context) {
    Widget _getImage() {
      if (icon != null) {
        return SvgPicture.asset(
          icon!,
          width: 15,
          color: GlorifiColors.darkBlue,
        );
      }
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: 48.0),
      child: Center(
        child: Container(
          height: 90.0,
          width: 90.0,
          child: _getImage(),
        ),
      ),
    );
  }
}
