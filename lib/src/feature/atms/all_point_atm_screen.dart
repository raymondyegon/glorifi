import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AllPointAtmScreen extends StatelessWidget {
  const AllPointAtmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.white,
      appBar: GlorifiAppBar(
        title: TextConstants.allPoint,
        elevation: 0,
        disableLeading: true,
        trailing: Trailing(
          text: TextConstants.close,
          onTap: Get.back,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 100.h, left: 10.w, right: 10.w),
        child: WebView(
          initialUrl: TextConstants.allPointMapUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
