import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CCMerchantName extends StatelessWidget {
  const CCMerchantName(
      {Key? key,
        required this.name})
      : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(name,
      style: leadBold24Primary(color: GlorifiColors.darkBlue),),
    );
  }
}
