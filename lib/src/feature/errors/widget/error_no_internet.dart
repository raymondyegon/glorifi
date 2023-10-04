import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/feature/errors/widget/base_error_widget.dart';

class ErrorNoInternet extends BaseErrorWidget {
  static ErrorUiModel _noInternetErrorWeb = ErrorUiModel(
    svgIconPath: "icons/error_no_internet.svg",
    title: "No Internet",
    subtitle: "Poor network connection.",
    content: "Please check your network connectivity or try again later.",
    actionTitle: "Retry",
    action: () {},
  );

  static ErrorUiModel _noInternetErrorMobile = ErrorUiModel(
    title: "No Internet",
    subtitle: "Like much of Washington DC, there is a disconnect. ",
    content: "Make sure WiFi or mobile data is turned on and try again. ",
    actionTitle: "Retry",
    action: () {},
  );

  ErrorNoInternet({Key? key, Function()? onTap})
      : super(
            key: key,
            errorUiModelWeb: _noInternetErrorWeb,
            errorUiModelMobile: _noInternetErrorMobile) {
    _noInternetErrorMobile.action = onTap;
    _noInternetErrorWeb.action = onTap;
  }
}
