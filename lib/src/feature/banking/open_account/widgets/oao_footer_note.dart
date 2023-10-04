import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/legal/widgets/glorifi_webview.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/glorifi_assets.dart';

class OAOFooterNote extends StatelessWidget {
  final String? title;
  final String? plainText;
  final TextSpan? customText;

  const OAOFooterNote({Key? key, this.title, this.plainText, this.customText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              title!,
              style:
                  captionRegular14Primary(color: GlorifiColors.cornflowerBlue)
                      .copyWith(height: 20 / 14),
            ),
          ),
        if (plainText != null)
          Text(
            plainText as String,
            style: xSmallSemiBold12Primary(color: GlorifiColors.creditBgGrey)
                .copyWith(height: 20 / 12),
          ),
        if (customText != null)
          RichText(
            text: TextSpan(
              children: [customText!],
              style: xSmallSemiBold12Primary(color: GlorifiColors.creditBgGrey)
                  .copyWith(height: 20 / 12),
            ),
          ),
      ],
    );
  }
}

TextSpan textSpanHyperLink({required String text, required String url}) {
  return TextSpan(
      text: text,
      style: xSmallBold12Primary(color: GlorifiColors.darkBlue)
          .copyWith(height: 20 / 12),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          if (kIsWeb) {
            launch(url);
          } else {
            Get.to(GlorifiWebView(
              title: text.capitalize!,
              url: url,
            ));
          }
        });
}

GestureRecognizer infoModal(context, title, body) {
  return TapGestureRecognizer()
    ..onTap = () {
      showDialog(
          barrierColor: GlorifiColors.midnightBlueColor.withOpacity(0.95),
          context: context,
          builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              content: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(GlorifiAssets.close),
                            )
                          ]),
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: GlorifiColors.midnightBlueColor,
                            height: 24 / 14),
                      ).paddingOnly(bottom: 10),
                      Text(body,
                          style: TextStyle(
                            fontSize: 14,
                          ))
                    ]),
              )));
    };
}
