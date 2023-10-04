import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/okta_mixin.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/mobile_number_controller_mixin.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/zip_code_controller_mixin.dart';
import 'package:glorifi/src/model/formatted_address.dart';
import 'package:glorifi/src/services/authentication_service.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:intl/intl.dart';

import 'preferred_name_controller_mixin.dart';

class CreateProfileController extends GetxController
    with
        OktaMixin,
        ZipCodeControllerMixin,
        MobileNumberControllerMixin,
        PreferredNameControllerMixin {
  final AuthenticationService _authService = Get.find<AuthenticationService>();
  bool loading = false;
  String redirectArgument = "";

  RxBool havePhoneError=false.obs;
  RxString  errorMessagePhone="".obs;

  RxBool haveEmailError=false.obs;
  RxString  errorMessageEmail="".obs;


  RxBool haveFirstNameError=false.obs;
  RxString  errorMessageFirstName="".obs;


  RxBool haveMiddleNameError=false.obs;
  RxString  errorMessageMiddleName="".obs;

  RxBool haveLastNameError=false.obs;
  RxString  errorMessageLastName="".obs;


  RxBool havePreferredNameError=false.obs;
  RxString  errorMessagePreferredName="".obs;


  RxBool haveDateError=false.obs;
  RxString  errorMessageDate="".obs;

  RxBool haveZipError=false.obs;
  RxString  errorMessageZip="".obs;



  final pageStateController = PageState.DEFAULT.obs;

  final verifyMemberStatus = VerifyMember.inProgress.obs;
  final _verifyMemberStreamController =
      StreamController<VerifyMember>.broadcast();

  get verifyMemberStream => _verifyMemberStreamController.stream;

  updateVerifyMemberStatus(VerifyMember verifyMember) {
    _verifyMemberStreamController.add(verifyMember);
    verifyMemberStatus(verifyMember);
  }

  final _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;
  String get email => _emailController.text.trim();

  bool get validEmail {
    return EmailValidator.validate(_emailController.text);
  }

  final _firstNameController = TextEditingController();

  TextEditingController get firstNameController => _firstNameController;

  bool get firstNameValid {
    if (_firstNameController.text.startsWith(" ")) {
      return false;
    } else {
      return _firstNameController.text.isNotEmpty;
    }
  }

  final _middleNameController = TextEditingController();

  TextEditingController get middleNameController => _middleNameController;

  bool get middleNameValid {
    // final pattern = r"(^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]*$)";
    // RegExp regex = RegExp(pattern);
    // if (middleNameController.text.isNotEmpty &&
    //     !regex.hasMatch(middleNameController.text))
    //   return false;
    // else
    if (middleNameController.text.startsWith(" ")) {
      return false;
    } else
      return true;
  }

  final _lastNameController = TextEditingController();

  TextEditingController get lastNameController => _lastNameController;

  bool get lastNameValid {
    if (_lastNameController.text.startsWith(" ")) {
      return false;
    } else {
      return _lastNameController.text.isNotEmpty;
    }
  }

  String get greetingsName => preferredNameController.text.trim().isNotEmpty
      ? preferredNameController.text
      : firstNameController.text;

  TextEditingController get dobController => _dobController;
  final _dobController = TextEditingController();

  bool get dobValid {
    bool _valid = false;
    DateFormat _birthFormat = DateFormat('MM/dd/yyyy');
    try {
      DateTime birthDate = _birthFormat.parse(_dobController.text);

      if (_isAgeGreaterThanMinimumAge(birthDate) &&
          _isAgeNotMoreThanMaxAge(birthDate) &&
          dobController.text == _birthFormat.format(birthDate)) {
        _valid = true;
        _dobController.selection = TextSelection.fromPosition(
            TextPosition(offset: _dobController.text.length));
      }
    } catch (e) {
      Log.error(e);
    }
    return _valid;
  }

  bool _isAgeGreaterThanMinimumAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    DateTime minAgeDate = DateTime(
      birthDate.year + 13,
      birthDate.month,
      birthDate.day,
    );

    return minAgeDate.isBefore(today);
  }

  bool _isAgeNotMoreThanMaxAge(DateTime birthDate) {
    DateTime today = DateTime.now();

    DateTime maxAgeDate = DateTime(
      today.year - 120,
      today.month,
      today.day,
    );

    return birthDate.isAfter(maxAgeDate);
  }

  String get formatedDob {
    String _returnDate = "1999-01-01";
    try {
      DateFormat _birthFormat = DateFormat('MM/dd/yyyy');
      DateFormat _returnFormat = DateFormat('yyyy-MM-dd');
      _returnDate =
          _returnFormat.format(_birthFormat.parse(_dobController.text));
    } catch (e) {
      Log.error(e);
    }
    return _returnDate;
  }

  FormattedAddress address = FormattedAddress();

  bool get addressValid {
    return address.formattedAddress != null;
  }

  void verify() async {
    updateVerifyMemberStatus(VerifyMember.inProgress);
    try {
      await authService.verify(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        emailAddress: emailController.text,
        birthDate: formatedDob,
        zip: zipController.text,
        phoneNumber: mobileController.text,
        middleName: middleNameController.text,
        preferredName: preferredNameController.text,
      );
      updateVerifyMemberStatus(VerifyMember.accepted);
    } catch (e) {
      updateVerifyMemberStatus(VerifyMember.denied);
    }
  }

  Future<bool> sendOtp() async {
    pageStateController(PageState.LOADING);
    try {
      final response = await _authService.sendOtp(email);
      if (response['success'] == true) {
        pageStateController(PageState.DEFAULT);
        return true;
      } else {
        pageStateController(PageState.DEFAULT);
        showSnackBar(response['message'] ?? "Unable to send OTP.");
        return false;
      }
    } on CustomException catch (ex) {
      pageStateController(PageState.DEFAULT);
      showSnackBar(ex.errorMessage);
      return false;
    } catch (error) {
      pageStateController(PageState.DEFAULT);
      showSnackBar("Unable to send OTP.");
      return false;
    }
  }
}

enum VerifyMember { inProgress, accepted, denied }

enum PersonalDetails {
  emailAddress,
  firstName,
  lastName,
  mobileNumber,
  zip,
  birthDate
}
