import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_mobile_widget.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_web_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BaseErrorWidget extends StatelessWidget {
  final ErrorUiModel errorUiModelWeb;
  final ErrorUiModel errorUiModelMobile;

  const BaseErrorWidget({
    Key? key,
    required this.errorUiModelWeb,
    required this.errorUiModelMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) => _pageContent(sizingInfo),
    );
  }

  Widget _pageContent(AdaptiveSizingInfo sizingInfo) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.all(16.w),
      child: sizingInfo.isNativeMobile
          ? BaseErrorMobileWidget(
              errorUiModel: errorUiModelMobile,
            )
          : BaseErrorWebWidget(
              errorUiModel: errorUiModelWeb,
            ),
    );
  }
}
