import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/onboard/value/model/value_content.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

class ValueContentWidget extends StatelessWidget {
  final ValueContent valueContent;

  const ValueContentWidget({
    Key? key,
    required this.valueContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogoScreen = valueContent.title == "";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: GlorifiValues.margin_32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment:
            isLogoScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          isLogoScreen
              ? SvgPicture.asset('assets/images/glorifi_logo/logo_dark_bg.svg')
              : Text(
                  valueContent.title.toUpperCase(),
                  style: arvo30Style,
                ),
          SizedBox(
              height: isLogoScreen
                  ? GlorifiValues.margin_32
                  : GlorifiValues.margin),
          Text(
            valueContent.subtitle,
            style: sans16Style.copyWith(height: 1.5),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
