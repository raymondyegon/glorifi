import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/event_broadcaster.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/enable_credit_score_smfa_response_model.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/initial_endable_credit_score_response_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/address_data.dart';
import 'package:glorifi/src/model/personal_snapshot/enable_credit_score_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class EnableCreditScoreController extends BaseController {
  EnableCreditScoreModel enableCreditScoreModel = EnableCreditScoreModel.empty();
  final ProfileController _profileController = Get.put(ProfileController());
  final EditProfileController _editProfileController = Get.find<EditProfileController>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var dobController = TextEditingController();

  RxBool fetchingAddressData = false.obs;
  RxBool isLoading = false.obs;

  final _dataHelper = DataHelperImpl.instance;
  RxBool isButtonEnable = false.obs;

  @override
  void onInit() {
    loadProfileInfo();
    _fetchAddressData();
    checkEnableButton();
    super.onInit();
  }

  void loadProfileInfo() {
    firstNameController.text = _profileController.userProfile.firstName != ''
        ? _profileController.userProfile.firstName
        : '';
    lastNameController.text = _profileController.userProfile.lastName != ''
        ? _profileController.userProfile.lastName
        : '';

    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String birthDate = formatter.format(_profileController.userProfile.birthDate);
    dobController.text = birthDate;
    enableCreditScoreModel.identity.email.first.email = _profileController.userProfile.email;
  }

  checkEnableButton() {
    isButtonEnable.value = firstNameController.text.trim().isNotEmpty && lastNameController.text.trim().isNotEmpty && dobController.text.trim().isNotEmpty && dobController.text.trim().length == 10;
  }


  _fetchAddressData() async {
    try {
      fetchingAddressData(true);
      final response = await _dataHelper.apiHelper.fetchAddress();
      await response.fold((l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      }, (res) {
        if (res != null && res['success']) {
          AddressData addressData = AddressData.fromJson(res['data']['Address']);

          if (enableCreditScoreModel.identity.address.first.addressLine1 == '') {
            enableCreditScoreModel.identity.address.first.addressLine1 =
                addressData.addrAddressLine1;
            enableCreditScoreModel.identity.address.first.addressLine2 =
                addressData.addrAddressLine2;
            enableCreditScoreModel.identity.address.first.city = addressData.addrCity;
            enableCreditScoreModel.identity.address.first.postalCode = addressData.addrPostalCode;
            enableCreditScoreModel.identity.address.first.regionFullName = addressData.addrState;
            enableCreditScoreModel.identity.address.first.region =
                USStates.getAbbreviation(addressData.addrState);
          }
        }
      });
    } catch (e) {
      Log.error(e);
    } finally {
      fetchingAddressData(false);
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    super.onClose();
  }

  bool get dobValid {
    bool _valid = false;
    DateFormat _birthFormat = DateFormat('MM/dd/yyyy');
    try {
      DateTime birthDate = _birthFormat.parse(dobController.text);

      if (_isAgeGreaterThan18(birthDate) &&
          _isAgeNotMoreThan120(birthDate) &&
          dobController.text == _birthFormat.format(birthDate)) {
        _valid = true;
        dobController.selection =
            TextSelection.fromPosition(TextPosition(offset: dobController.text.length));
      }
    } catch (e) {
      Log.error(e);
    }
    return _valid;
  }

  bool _isAgeGreaterThan18(DateTime birthDate) {
    DateTime today = DateTime.now();

    DateTime minAgeDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    return minAgeDate.isBefore(today);
  }

  bool _isAgeNotMoreThan120(DateTime birthDate) {
    DateTime today = DateTime.now();

    DateTime maxAgeDate = DateTime(
      today.year - 120,
      today.month,
      today.day,
    );

    return birthDate.isAfter(maxAgeDate);
  }

  void next() {
    saveData();
    Get.toNamed(Routes.enableCreditScoreStep2Address);
  }

  void saveData() {
    enableCreditScoreModel.identity.name.firstName = firstNameController.text;
    enableCreditScoreModel.identity.name.lastName = lastNameController.text;
    List<String> _date = dobController.text.split('/');
    enableCreditScoreModel.identity.dateOfBirth.month = _date.first;
    enableCreditScoreModel.identity.dateOfBirth.day = _date[1];
    enableCreditScoreModel.identity.dateOfBirth.year = _date[2];
    enableCreditScoreModel.identity.phone.first.number = _profileController.userProfile.phoneNumber;
  }

  void navigateAfterFlowIsDone() {
    _profileController.updateCreditScoreEnabled(true);
    _editProfileController.onChangedCreditScoreEnabled(true);
    Get.put(AccountFlagsController()).flags.value.hasCreditPermission = true;
    Get.until((route) => route.settings.name == Routes.enableCreditScoreStep1Name);
    Get.back();
  }

  Future submit(BuildContext context, AdaptiveSizingInfo sizingInfo) async {
    final _ipAddress = await Ipify.ipv64();
    enableCreditScoreModel.ipAddress = _ipAddress;

    if (sizingInfo.isNativeMobile || sizingInfo.isWebMobile) {
      Get.toNamed(Routes.creditScoreRetrieveSuccess);
      try {
        final InitialEnableCreditScoreResponseModel? response1 =
            await _dataHelper.apiHelper.initiateEnableCreditScore(enableCreditScoreModel.toJson());
        if (response1?.data?.decision?.toLowerCase() == 'allow') {
          final EnableCreditScoreSmfaResponseModel? response2 =
              await _dataHelper.apiHelper.enableCreditScoreSMFASendUrl();
          if (response2?.data?.instaTouch != null) {
            await launch(response2!.data!.instaTouch!);

            navigateAfterFlowIsDone();
            //final EnableCreditScoreController controller =
            // Get.find<EnableCreditScoreController>();
            //     onPressedButton: controller.navigateAfterFlowIsDone,
            //Get.offNamed(Routes.enableCreditScoreSuccessScreen);
            //TODO add new screen with message was sent, success will be shown via dynamic link
          } else {
            Get.back();
          }
        } else {
          Get.back();
        }
      } catch (e) {
        Get.back();
        showSnackBar(e.toString());
      }
    } else {
      showCreditScoreRetrieveSuccessDialog(context);
      try {
        final InitialEnableCreditScoreResponseModel? response1 =
            await _dataHelper.apiHelper.initiateEnableCreditScore(enableCreditScoreModel.toJson());
        if (response1?.data?.decision?.toLowerCase() == 'allow') {
          final EnableCreditScoreSmfaResponseModel? response2 =
              await _dataHelper.apiHelper.enableCreditScoreSMFASendUrl();
          if (response2?.data?.instaTouch != null) {
            await launch(response2!.data!.instaTouch!);
            Navigator.of(context).pop();
            navigateAfterFlowIsDone();
            //TODO add new modal message was sent, success will be shown via dynamic link
            //showCreditScoreSuccessDialog(context);
          } else {
            Get.back();
          }
        } else {
          Get.back();
        }
      } catch (e) {
        Get.back();
        showSnackBar(e.toString());
      }
    }
  }
}

showCreditScoreRetrieveSuccessDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AdaptiveBuilder(builder: (BuildContext dialogContext, sizingInfo) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: Padding(
              padding: sizingInfo.isTablet || sizingInfo.isDesktop
                  ? EdgeInsets.only(top: 115.0, left: 100, bottom: 115, right: 100)
                  : EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 75.sp, width: 75.sp, child: GlorifiSpinner()),
                  SizedBox(height: 48.h),
                  Text(
                    TextConstants.retrieving_your_credit_scoreText,
                    style: headlineRegular26Secondary(color: GlorifiColors.cornflowerBlue),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    },
  );
}

showCreditScoreSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AdaptiveBuilder(builder: (BuildContext dialogContext, sizingInfo) {
          return AlertDialog(
            backgroundColor: Color(0xff03213D),
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: Padding(
              padding: sizingInfo.isTablet || sizingInfo.isDesktop
                  ? EdgeInsets.only(top: 105.0, left: 100, bottom: 72, right: 100)
                  : EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/successful.svg',
                    width: 64,
                  ),
                  SizedBox(height: 48.0.h),
                  Text(
                    'Your Credit Score Was Added!',
                    textAlign: TextAlign.center,
                    style: headlineRegular26Secondary(
                      color: GlorifiColors.white,
                    ),
                  ),
                  SizedBox(height: 36.0.h),
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      EventBroadcaster.instance.addEvent(CreditScoreWasEnabledEvent());
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: Size(double.infinity, 0),
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: Text('Done', style: bodyBold18Primary(color: GlorifiColors.ebonyBlue)),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    },
  );
}
