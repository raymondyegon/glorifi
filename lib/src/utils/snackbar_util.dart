import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

///shows a snackbar with any message
void showSnackBar(String message) {
  if (Get.context != null) {
    ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();

    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}

void apiExceptionMessage(int code, {bool? toast}) {
  String message = '';

  switch (code) {
    case 002:
    case 001:
      message = networkError;
      break;
    case 500:
      message = serverError;
      break;
    case 408:
    case 004:
      message = serverConnectionError;
      break;
    case 404:
      message = resourceNotFound;
  }
  // if (toast == null || toast == false) {
  //   if (Get.context != null) {
  //     ScaffoldMessenger.of(Get.context!).removeCurrentSnackBar();

  //     ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //       content: Text(
  //         message,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // } else {
  //   showErrorToast(message);
  // }
}

void showErrorToast(String message) {
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: GlorifiColors.redError,
        borderRadius: 100,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(24),
        duration: Duration(seconds: 3),
        maxWidth: 500,
      ),
    );
  });
}
