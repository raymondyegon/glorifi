import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class Error404Widget extends BaseErrorWidget {
  static ErrorUiModel _uiModelErrorWeb = ErrorUiModel(
    svgIconPath: "icons/error_404.svg",
    title: "404444444! Error",
    subtitle: "Oh no!",
    content: "Something went wrong. Please try again.",
    actionTitle: "Back to Feed",
    action: () {},
  );

  static ErrorUiModel _uiModelErrorMobile = ErrorUiModel(
    title: "404 score and seven years ago, something went wrong",
    subtitle: "",
    content: "We’re working to make a more perfect website.",
    actionTitle: "Back to feed",
    action: () {},
  );

  Error404Widget({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _uiModelErrorWeb,
            errorUiModelMobile: _uiModelErrorMobile) {
    _uiModelErrorWeb.action = onTap;
    _uiModelErrorMobile.action = onTap;
  }
}
