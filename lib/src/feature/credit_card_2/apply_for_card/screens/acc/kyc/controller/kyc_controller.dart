import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/models/kyc_validation_error_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/service/acc_service.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:intl/intl.dart';
import 'package:us_states/us_states.dart';

class KYCController extends BaseController {
  final ProfileController _profileController = Get.find();
  final ACCController accController = Get.find();
  final ACCService _accService = Get.find<ACCService>();

  final showErrorScreen = false.obs;

  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);

  get pageState => _pageStateController.value;

  Future<void> validateBasicInformation() async {
    if (accController.isMockEnabled) {
      _pageStateController(PageState.SUCCESS);
    } else {
      Map<String, dynamic> data = {
        "demographic": {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "date_of_birth": DateFormat("MM/dd/yyyy")
              .parse(dobController.text)
              .toServiceFormat(),
          // "date_of_birth": dobController.text,
        }
      };
      try {
        _pageStateController(PageState.LOADING);
        await _accService.validateBasicInformation(data);
        _pageStateController(PageState.SUCCESS);
      } catch (e) {
        BasicInformationValidationErrorModel _error;
        try {
          _error = BasicInformationValidationErrorModel.fromJson(
            jsonDecode(e.toString()),
          );
        } catch (e, stackTrace) {
          Log.error(e.toString());
          Log.error(stackTrace.toString());
          throw e.toString();
        }
        _pageStateController(PageState.ERROR);
        _error.message = _error.message + ".";
        _error.data.toJson().forEach((key, value) {
          if ((value as List).isNotEmpty) {
            _error.message = _error.message + " " + value.first;
          }
        });
        Log.debug(_error.message);
        showErrorToast(_error.message);
        _pageStateController(PageState.ERROR);
      }
    }
  }

  Future<void> validateContactInformation() async {
    if (accController.isMockEnabled) {
      _pageStateController(PageState.SUCCESS);
    } else {
      Map<String, dynamic> data = {
        "email": emailController.text,
        "phone_number":
            phoneNumberController.text.replaceAll(RegExp('[^0-9]'), ''),
      };
      try {
        _pageStateController(PageState.LOADING);
        await _accService.validateContactInformation(data);
        _pageStateController(PageState.SUCCESS);
      } catch (e) {
        ContactInformationValidationErrorModel _error;
        _pageStateController(PageState.ERROR);
        try {
          _error = ContactInformationValidationErrorModel.fromJson(
            jsonDecode(e.toString()),
          );
          _error.message = _error.message + ".";
          _error.data.toJson().forEach((key, value) {
            if ((value as List).isNotEmpty) {
              _error.message = _error.message + " " + value.first;
            }
          });
          Log.error(_error.message);
          showErrorToast(_error.message);
        } catch (e, stackTrace) {
          Log.error(e.toString());
          Log.error(stackTrace.toString());
          showErrorToast("Something went wrong");
        }
        _pageStateController(PageState.ERROR);
      }
    }
  }

  /// Blocked State & Address Validation
  get CCNotAvailableInSelectedStateTitle =>
      'GloriFi Credit Cards Are Not Available To Residents Of ${getAddressGetXController.selectedState} at This Time.';

  bool checkIfStateIsBlocked() {
    return getAddressGetXController.noAvailableStateList.contains(
        USStates.getAbbreviation(getAddressGetXController.selectedState));
  }

  Future<void> validateAddressInformation() async {
    if (accController.isMockEnabled) {
      _pageStateController(PageState.SUCCESS);
    } else {
      Map<String, dynamic> data = {
        "demographic": {
          "address": {
            "line1": getAddressGetXController.streetController.text,
            "line2": getAddressGetXController.aptController.text,
            "city": getAddressGetXController.cityController.text,
            "zip": getAddressGetXController.zipController.text,
            "state": USStates.getAbbreviation(
                getAddressGetXController.selectedState),
          }
        }
      };
      try {
        _pageStateController(PageState.LOADING);
        await _accService.validateAddressInformation(data);
        _pageStateController(PageState.SUCCESS);
      } catch (e) {
        AddressValidationErrorModel _error;
        try {
          _error = AddressValidationErrorModel.fromJson(
            jsonDecode(e.toString()),
          );
          _error.message = _error.message + ".";
          _error.data.toJson().forEach((key, value) {
            if ((value as List).isNotEmpty) {
              _error.message = _error.message + " " + value.first;
            }
          });
          Log.error(_error.message);
          showErrorToast(_error.message);
        } catch (e, stackTrace) {
          Log.error(e.toString());
          Log.error(stackTrace.toString());
          showErrorToast("Something went wrong");
        }
        _pageStateController(PageState.ERROR);
      }
    }
  }

  /// Tokenized SSN
  late String tokenizedSSN;

  Future<void> tokenizationSSNInformation() async {
    if (accController.isMockEnabled) {
      _pageStateController(PageState.SUCCESS);
      // _populateDemographicDataWithSSN();
    } else {
      Map<String, dynamic> data = {"value": ssnController.text};
      try {
        _pageStateController(PageState.LOADING);
        tokenizedSSN = await _accService.tokenizationSSN(data);
        _pageStateController(PageState.SUCCESS);
        _populateDemographicDataWithSSN();
      } catch (e, stackTrace) {
        Log.error(e.toString());
        Log.error(stackTrace.toString());
        showErrorToast("Something went wrong");
        _pageStateController(PageState.ERROR);
      }
    }
  }

  String _getLastFourDigitOfSSN() {
    return ssnController.text.substring(ssnController.text.length - 4);
  }

  void _populateDemographicDataWithSSN() {
    Get.find<ACCMemberApplicationModel>().demographic =
        Get.find<ACCMemberApplicationModel>().demographic!.copyWith(
              ssn: tokenizedSSN,
              lastFourSsn: _getLastFourDigitOfSSN(),
            );
    Log.debug(Get.find<ACCMemberApplicationModel>().toJson());
  }

  /// Populate ACCMemberModel
  void populateDemographicData() {
    try {
      Get.find<ACCMemberApplicationModel>().demographic = Demographic(
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        dateOfBirth: DateFormat('MM/dd/yyyy').parse(dobController.text),
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        primaryAddress: Address(
          line1: primaryAddressController.streetController.text,
          line2: primaryAddressController.aptController.text,
          zip: primaryAddressController.zipController.text,
          city: primaryAddressController.cityController.text,
          state:
              USStates.getAbbreviation(primaryAddressController.selectedState),
          type: "RESIDENCE",
        ),
        mailingAddress: Address(
          line1: mailingAddressController.streetController.text,
          line2: mailingAddressController.aptController.text,
          zip: mailingAddressController.zipController.text,
          city: mailingAddressController.cityController.text,
          state:
              USStates.getAbbreviation(mailingAddressController.selectedState),
          type: "SHIPPING",
        ),
      );
    } on Exception catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
    }
  }

  /// Since user can have different mailing address, we are
  /// instantiating AddressController twice for respective scenario.
  /// Scenario 1: User wants the card delivered in his primary address then
  /// we want to use [primaryAddressController]
  /// Scenario 2: User wants the card at different mailing address other than
  /// his primary address. Then we will use [mailingAddressController]
  final AddressController primaryAddressController = AddressController();
  final AddressController mailingAddressController = AddressController();

  /// Deciding which controller to use based on if user wants the
  /// card at different mailing address
  AddressController get getAddressGetXController =>
      getHasDifferentMailingAddress
          ? mailingAddressController
          : primaryAddressController;

  RxBool _hasDifferentMailingAddress = false.obs;

  void toggleDifferentMailingAddress(value) =>
      _hasDifferentMailingAddress(value);

  bool get getHasDifferentMailingAddress => _hasDifferentMailingAddress.value;

  /// Text Editing Controllers
  /// Basic Information
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();

  void prefillTextFields() async {
    ProfileModel _profile = _profileController.userProfile;
    Address? _address =
        Get.find<ACCMemberApplicationModel>().demographic?.primaryAddress;

    firstNameController.text = _profile.firstName;
    middleNameController.text = _profile.middleName ?? '';
    lastNameController.text = _profile.lastName;
    dobController.text = _profile.birthDate.toDisplayFormat();

    phoneNumberController.text = _profile.phoneNumber.replaceAll("-", " ");
    emailController.text = _profile.email as String;

    primaryAddressController.streetController.text = _address?.line1 ?? '';
    primaryAddressController.aptController.text = _address?.line2 ?? '';
    primaryAddressController.zipController.text = _address?.zip ?? '';
    primaryAddressController.cityController.text = _address?.city ?? '';
    primaryAddressController.setSelectedState(_address?.state ?? '');

    populateDemographicData();
  }

  void fillAddressFormField(PlaceDetailModel place) async {
    primaryAddressController.fillAddressFormField(place);
  }

  void fillMailingAddressFormField(PlaceDetailModel place) async {
    mailingAddressController.fillAddressFormField(place);
  }

  void clearTextFields() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    dobController.clear();
    phoneNumberController.clear();
    emailController.clear();
  }

  void disposeTextFields() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
  }

  @override
  void onInit() {
    prefillTextFields();
    super.onInit();
  }

  /// TODO: Need to handle dispose carefully because user can navigate back to previous screen for editing.
/*@override
  void dispose() {
    disposeTextFields();
    primaryAddressController.disposeTextFields();
    mailingAddressController.disposeTextFields();
    super.dispose();
  }*/
}

class AddressController extends GetxController {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController aptController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  /// State: (Need to check to available state)
  RxString _selectedState = "".obs;

  List<String> get noAvailableStateList =>
      ['AK', 'AZ', 'CA', 'HI', 'MA', 'MO', 'MD', 'NV', 'NJ', 'NY'];

  get selectedState => _selectedState.value;

  void setSelectedState(String value) => _selectedState(value);

  void fillAddressFormField(PlaceDetailModel place) async {
    streetController.text =
        '${place.streetNumber != '' ? '${place.streetNumber} ' : ''}${place.route}';
    aptController.text = '';
    zipController.text = place.zipCode;
    cityController.text = place.city;
    setSelectedState(place.state);
  }

  void clearTextFields() {
    streetController.clear();
    aptController.clear();
    cityController.clear();
    _selectedState.close();
    zipController.clear();
  }

  void disposeTextFields() {
    streetController.dispose();
    aptController.dispose();
    cityController.dispose();
    zipController.dispose();
  }

  /// TODO: Need to handle dispose carefully because user can navigate back to previous screen for editing.
/*@override
  void dispose() {
    disposeTextFields();
    super.dispose();
  }*/
}
