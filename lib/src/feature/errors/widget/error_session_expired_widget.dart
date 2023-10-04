import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class ErrorSessionExpiredWidget extends BaseErrorWidget {
  static ErrorUiModel _uiModelErrorWeb = ErrorUiModel(
    svgIconPath: "icons/error_session_expired.svg",
    title: "Whoops!",
    subtitle: "Your Session has Expired",
    content: "Due to inactivity your session has expired. Please login again.",
    actionTitle: "Login",
    action: () {},
  );

  static ErrorUiModel _uiModelErrorMobile = ErrorUiModel(
    title: "Session Expired",
    subtitle: "Due to inactivity your session has expired.",
    content: "Now, if we could only get that for Congress!",
    actionTitle: "Login",
    action: () {},
  );

  ErrorSessionExpiredWidget({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _uiModelErrorWeb,
            errorUiModelMobile: _uiModelErrorMobile) {
    _uiModelErrorWeb.action = onTap;
    _uiModelErrorMobile.action = onTap;
  }
}
