import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class Error500Widget extends BaseErrorWidget {
  static ErrorUiModel _uiModelErrorWeb = ErrorUiModel(
    svgIconPath: "icons/error_500.svg",
    title: "500 Error",
    subtitle: "Internal Server Error",
    content:
        "Something went wrong on our end. We are working to fix the problem.",
    actionTitle: "Retry",
    action: () {},
  );

  static ErrorUiModel _uiModelErrorMobile = ErrorUiModel(
    title: "500 Error ",
    subtitle: "Sorry something is broken",
    content:
        "But here is a fun fact: George Washington never actually had wooden teeth. He wore dentures made from other materials including ivory, gold, lead, and even animal and human teeth.",
    actionTitle: "Retry",
    action: () {},
  );

  Error500Widget({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _uiModelErrorWeb,
            errorUiModelMobile: _uiModelErrorMobile) {
    _uiModelErrorWeb.action = onTap;
    _uiModelErrorMobile.action = onTap;
  }
}
