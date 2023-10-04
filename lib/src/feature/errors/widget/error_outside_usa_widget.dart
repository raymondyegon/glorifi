import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class ErrorOutsideUSAWidget extends BaseErrorWidget {
  static const title = "Sorry, you must be in the U.S. to open an account.";
  static const content = "We have detected you're currently outside of the U.S. Please try again when in the country.";

  static ErrorUiModel _uiModelErrorWeb = ErrorUiModel(
    title: title,
    content: content,
    actionTitle: "Back",
    action: () {},
  );

  static ErrorUiModel _uiModelErrorMobile = ErrorUiModel(
    title: title,
    content: content,
    actionTitle: "Back",
    action: () {},
  );

  ErrorOutsideUSAWidget({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _uiModelErrorWeb,
            errorUiModelMobile: _uiModelErrorMobile) {
    _uiModelErrorWeb.action = onTap;
    _uiModelErrorMobile.action = onTap;
  }
}
