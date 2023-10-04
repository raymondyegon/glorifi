import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class ErrorTimeoutWidget extends BaseErrorWidget {
  static ErrorUiModel _uiModelErrorWeb = ErrorUiModel(
    svgIconPath: "icons/error_timeout.svg",
    title: "Error",
    subtitle: "The connection has timed out",
    content: "The server is taking too long to respond.",
    actionTitle: "Retry",
    action: () {},
  );

  static ErrorUiModel _uiModelErrorMobile = ErrorUiModel(
    title: "Time Keeps on Slipping",
    subtitle: "The connection has timed out",
    content: "The server is taking too long to respond.",
    actionTitle: "Into the future",
    action: () {},
  );

  ErrorTimeoutWidget({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _uiModelErrorWeb,
            errorUiModelMobile: _uiModelErrorMobile) {
    _uiModelErrorWeb.action = onTap;
    _uiModelErrorMobile.action = onTap;
  }
}
