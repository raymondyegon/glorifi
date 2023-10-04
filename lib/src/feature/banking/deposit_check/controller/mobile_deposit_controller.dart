import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/deposit_check_camera_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/model/account_data.dart';
import 'package:glorifi/src/feature/banking/widgets/alert_dialog.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

enum SubmittedCheckResult {
  None,
  Complete,
  PendingReview,
  Failed,
}

enum SubmitDepositReturnCode {
  None,
  Ok,
  AmountMismatch,
  AmountAboveLimits,
  CannotReadCheck,
  Other,
}

class MobileDepositController extends BaseController {
  final mobileDepositKey = GlobalKey<FormState>();
  final depositAmountValueController =
      TextEditingController(text: r"$0.00").obs;
  final depositAmountVerifyCheckReturnCode = SubmitDepositReturnCode.None.obs;
  var mobileDepositToChosenAccount = Rxn<AccountData>();
  final mobileDepositRoutingNumberController =
      TextEditingController(text: "000012345")
          .obs; // TODO: in current flow it is static
  final mobileDepositAccountingNumberController =
      TextEditingController(text: "98434212")
          .obs; // TODO: in current flow it is static
  final mobileDepositToAccounts = <AccountData>[].obs;
  final depositTransactionSequenceNumber = "0".obs;
  RxDouble mobileDepositLimit = 0.0.obs;
  var submittedCheckResult = SubmittedCheckResult.None;

  final _dataHelper = DataHelperImpl.instance;

  @override
  void onInit() {
    getDepositLimit();
    super.onInit();
  }

  @override
  void onClose() {
    depositAmountValueController.value.dispose();
    super.onClose();
  }

  String getMobileDepositLimit() {
    return mobileDepositLimit.value > 0
        ? mobileDepositLimit.value.formatCurrencyWithZero()
        : "unknown";
  }

  Future getDepositLimit() async {
    final response = await _dataHelper.apiHelper.fetchMobileDepositLimit();
    response.fold(
      (l) => {},
      (r) => mobileDepositLimit.value =
          double.parse(r['data']["glorifi_accounts"][0]['crLimit'])
              .toPrecision(2),
    );
  }

  Future<void> verifyCheck() async {
    final profileController = Get.put(ProfileController());
    final cameraController = Get.put(DepositCheckCameraController());

    if (_depositAmountValueStringToDouble() > mobileDepositLimit.value) {
      depositAmountVerifyCheckReturnCode.value =
          SubmitDepositReturnCode.AmountAboveLimits;
      _finalizeSubmitDepositError();
      return;
    }

    final checkFrontImageMultipartFile = _getPictureData(
        cameraController.frontCheckPhoto.value.path, "checkFront.jpg");
    final checkBackImageMultipartFile = _getPictureData(
        cameraController.backCheckPhoto.value.path, "checkBack.jpg");
    final checkFrontImageMultipartFile1 = _getPictureData(
        cameraController.frontCheckPhoto.value.path, "checkFront.jpg");
    final checkBackImageMultipartFile1 = _getPictureData(
        cameraController.backCheckPhoto.value.path, "checkBack.jpg");

    // TODO: Remove below hack when profile will work
    if (profileController.userProfile.firstName.isEmpty) {
      profileController.userProfile.firstName = "Depositor10";
    }
    final data = dio.FormData.fromMap(<String, String>{
      "DepositorId": profileController
          .userProfile.firstName, // TODO: Change to memberId when works
      "AccountNumber": mobileDepositToChosenAccount.value!.number.toString(),
      "Amount": _depositAmountValueStringToDouble().toString(),
    });
    data.files.addAll([
      MapEntry("ImageFront", await checkFrontImageMultipartFile),
      MapEntry("ImageRear", await checkBackImageMultipartFile),
      MapEntry("ImageFront1", await checkFrontImageMultipartFile1),
      MapEntry("ImageRear1", await checkBackImageMultipartFile1),
    ]);

    final response = await DataHelperImpl.instance.apiHelper.depositCheck(data);
    response.fold(_handleSubmitDepositError, _handleSubmitDepositSuccess);
  }

  SubmittedCheckResult _mapStringToSubmittedCheckResult(String result) {
    switch (result) {
      case "Complete":
        return SubmittedCheckResult.Complete;
      case "PendingReview":
        return SubmittedCheckResult.PendingReview;
      case "Failed":
        return SubmittedCheckResult.Failed;
      default:
        return SubmittedCheckResult.None;
    }
  }

  Future<dio.MultipartFile> _getPictureData(
      String filePath, String fileName) async {
    return dio.MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );
  }

  void _handleSubmitDepositError(CustomException exception) {
    Log.error("handleSubmitDepositError: ${exception}");
    depositAmountVerifyCheckReturnCode.value = SubmitDepositReturnCode.Other;
    var errorCode = exception.errorCode.toString();
    var errorMessage = exception.errorMessage;

    // TODO: handle when we get a timeout
    // if (errorMessage.contains("Could not connect to the server"))

    try {
      var errorJson = json.decode(exception.errorMessage);
      var alogentException = errorJson['data']['alogent_response']['exception'];
      errorCode = alogentException['ErrorCode'];
      Log.debug("errorCode ${errorCode}");
      errorMessage = alogentException['Message'];
      Log.debug("errorMessage ${errorMessage}");

      if (errorCode == "UnsupportedJpegImageFormat") {
        if (errorMessage.contains(
            "The amount you entered did not match the amount detected")) {
          depositAmountVerifyCheckReturnCode.value =
              SubmitDepositReturnCode.AmountMismatch;
        } else if (errorMessage.contains("Cannot read check")) {
          depositAmountVerifyCheckReturnCode.value =
              SubmitDepositReturnCode.CannotReadCheck;
        }
      }
    } catch (e) {
      Log.error(e.toString());
    }

    _finalizeSubmitDepositError();
  }

  void _handleSubmitDepositSuccess(dynamic data) {
    Log.debug("handleSubmitDepositSuccess: ${data}");
    depositAmountVerifyCheckReturnCode.value = SubmitDepositReturnCode.Ok;

    try {
      final status = data['data']['alogent_status'];
      submittedCheckResult = SubmittedCheckResult.values.byName(status);
      depositTransactionSequenceNumber.value = data['data']['alogent_response']['item_sequence'];
    } catch (e) {
      Log.error(e.toString());
    }
  }

  void _finalizeSubmitDepositError() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Get.back();
      _showReturnCodeAlertDialog();
    });
  }

  void _showReturnCodeAlertDialog() {
    switch (depositAmountVerifyCheckReturnCode.value) {
      case SubmitDepositReturnCode.AmountMismatch:
        glorifiAlertDialog(
          "Oops, amounts don’t match",
          "Review amount on the check and verify against the amount you have entered.",
          "Dismiss",
        );
        break;
      case SubmitDepositReturnCode.AmountAboveLimits:
        glorifiAlertDialog(
          "Your deposit amount is above the available limit",
          "Your deposit amount is above the available deposit limit. Please deposit an amount below the limit.",
          "Dismiss",
        );
        break;
      case SubmitDepositReturnCode.CannotReadCheck:
        glorifiAlertDialog(
          "Sorry, this type of check is not supported",
          """
The check might not be recognized for various reasons, such as it being a foreign insitution check, illegible checks or damaged checks.

If you have questions or concerns, please contact customer service at 844-456-7434.""",
          "Dismiss",
        );
        break;
      default:
        glorifiAlertDialog(
          "We cannot process this check",
          """
We apologize for the inconvenience.

If you have any questions or concerns, please contact customer service at 844-456-7434.""",
          "Dismiss",
        );
        break;
    }
  }

  double _depositAmountValueStringToDouble() {
    return double.parse(depositAmountValueController.value.text
        .replaceAll(r"$", "")
        .replaceAll(",", ""));
  }
}
