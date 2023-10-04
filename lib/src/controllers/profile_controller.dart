import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:intl/intl.dart';

import '../utils/login_status/login_status.dart';

class ProfileController extends BaseController {
  var _greeting = "".obs;

  String get greeting => _greeting.value;

  Rx<ProfileModel> _userProfile = ProfileModel.empty().obs;
  Rx<String> _profileImageController = "".obs;
  String get profileImageString => _profileImageController.value;

  ProfileModel get userProfile => _userProfile.value;
  var preferredNameEnabled = false.obs;

  changePreferredNameEnabled(bool val) => preferredNameEnabled.value = val;
  var error;

  bool get profileCompleted => userProfile.isComplete;

  int get profileStepsComplete => userProfile.profileStepsComplete;

  int get profileStepsTotal => userProfile.totalProfileSteps;

  bool get hasExternalAccountLinked =>
      _userProfile.value.externalAccounts.isNotEmpty;

  @override
  void onInit() async {
    CheckLoginStatus.isLoggedIn().then((value) async {
      if (value) {
        _fetchProfile().then((value) => _fetchExternalAccounts());
      }
    });

    super.onInit();
  }

  List<String> get greetingMessage {
    bool isBirthday(DateTime birthday) {
      var now = DateTime.now();
      return birthday.month == now.month && birthday.day == now.day;
    }

    if (userProfile.firstName == "") {
      return [];
    }
    var hour = DateTime.now().hour;
    String name = userProfile.preferredName ?? userProfile.firstName;

    if (isBirthday(userProfile.birthDate)) {
      return ["Happy Birthday,", name];
    }
    return [
      hour < 12
          ? "Good Morning,"
          : hour < 17
              ? "Good Afternoon,"
              : "Good Evening,",
      name
    ];
  }

  // Convert timestamp to 'MMM yyyy'
  String getJoinedDate() {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    final String formatted = formatter.format(userProfile.joinDate);
    return formatted;
  }

  Future<void> _fetchProfile() async {
    try {
      final response = await DataHelperImpl.instance.apiHelper.getUserProfile();
      response.fold(
        print,
        (success) async {
          change(
            _userProfile(success),
            status: RxStatus.success(),
          );
        },
      );
      _profileImageController(_userProfile.value.profilePicture ?? "");
    } catch (e) {
      Log.error("Error from profile controller: ${e.toString()}");
      ProfileModel result = await Get.toNamed(Routes.PROFILE_ERROR_HANDLE);
      change(
        _userProfile(result),
        status: RxStatus.success(),
      );
      _profileImageController(_userProfile.value.profilePicture ?? "");
    }
  }

  Future<void> refreshProfile() async {
    await _fetchProfile();
    await _fetchExternalAccounts();
  }

  Future<void> _fetchExternalAccounts() async {
    try {
      final response =
          await DataHelperImpl.instance.apiHelper.getConnectedAccounts();
      response.fold((l) {
        // // TODO: Handle this error. Button in EditProfile to refetch?
        apiExceptionMessage(l.errorCode);
      }, (r) {
        final connectedAccounts = r.data.accounts as List<AccountsData>;
        final transformedAccounts = connectedAccounts.map((connectedAccount) {
          return ExternalAccount(
              institution: connectedAccount.name,
              mask: connectedAccount.mask,
              name: connectedAccount.officialName);
        });
        userProfile.externalAccounts = transformedAccounts.toList();
        change({}, status: RxStatus.success());
      });
    } catch (e) {
      // TODO: Handle this error. Button in EditProfile to refetch?
    }
  }

  void onPreferredNameUpdateSuccess(String preferredName) {
    _userProfile.value = _userProfile.value.copyWith(
      preferredName: preferredName,
    );
  }

  void onProfilePictureUpdateSuccess(String profilePicture) {
    _profileImageController(profilePicture);
    _userProfile.value = _userProfile.value.copyWith(
      profilePicture: profilePicture,
    );
  }

  void onZipCodeUpdateSuccess(String zipCode) {
    _userProfile.value = _userProfile.value.copyWith(zip: zipCode);
  }

  void updateMobileNumber(String mobileNumber) {
    _userProfile.value = _userProfile.value.copyWith(
      phoneNumber: mobileNumber,
    );
  }

  getBirthDateFormatted(DateTime? birthDate) {
    String returnValue =
        "${birthDate!.month.toString().padLeft(2, '0')}/${birthDate.day.toString().padLeft(2, '0')}/${birthDate.year.toString().padLeft(4, '0')}";
    return returnValue;
  }

  void updateCreditScoreEnabled(bool value) {
    _userProfile.value = _userProfile.value.copyWith(creditScoreEnabled: value);
  }

  getUserFullName() {
    return '${_userProfile.value.firstName} ${_userProfile.value.lastName}';
  }
}
