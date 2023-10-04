import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String? description;

  const TitleWidget({Key? key, required this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headlineBold26Secondary(color: GlorifiColors.almostBlack),
          ),
          SizedBox(height: 6),
          if (description != null)
            Text(
              description!,
              style: captionSemiBold14Primary(color: GlorifiColors.textDarkBlue),
            ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
