import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_rule_ui_model.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/point_earning_segment_ui_model.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/model/reward_point_rule_type.dart';
import 'package:intl/intl.dart';

class RewardLandingController extends GetxController {
  ProfileController _profileController = Get.find();
  LoyaltyController _loyaltyController = Get.find();
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final _pointEarningSegmentListController =
      RxList<PointEarningSegmentUiModel>();

  List<PointEarningSegmentUiModel> get pointEarningSegmentList =>
      _pointEarningSegmentListController.toList();

  final _userNameController = "".obs;

  String get userName => _userNameController.value;

  final _rewardPointController = 0.obs;

  int get rewardPoint => _rewardPointController.value;
  String get rewardPointString => myFormat.format(rewardPoint);

  final _earnPointActionFinancialAccount =
      RxList<PointEarningRuleUiModel>.empty();

  List<PointEarningRuleUiModel> get earnPointFinancialAccount =>
      _earnPointActionFinancialAccount.toList();

  @override
  void onInit() {
    _prepareRewardPointData();
    _prepareRewardSegmentList();
    _prepareEarnPointActionFinancialAccount();
    super.onInit();
  }

  void _prepareRewardPointData() {
    _userNameController(_profileController.userProfile.preferredName??_profileController.userProfile.firstName);
    _rewardPointController(_loyaltyController.currentBalance);
  }

  Future<void> refreshPoints() async {
    await _loyaltyController.fetchPoints();
    _rewardPointController(_loyaltyController.currentBalance);
  }

  void _prepareRewardSegmentList() {
    List<PointEarningSegmentUiModel> pointEarningSegmentList = [
      PointEarningSegmentUiModel(
        title: 'Personalize your GloriFi profile',
        subtitle: 'Your GloriFi profile',
        pointEarningRuleList: [
          PointEarningRuleUiModel(
            type: RewardPointRuleType.COMPLETE_PROFILE,
            title: 'Complete your profile',
            subtitle: 'Enhance your experience.',
            iconPath: 'assets/icons/ic_profile_2.svg',
          ),
          PointEarningRuleUiModel(
            type: RewardPointRuleType.LINK_BANK_ACCOUNT,
            title: 'Link a bank account',
            subtitle: 'Unlock your financial snapshot.',
            iconPath: 'assets/icons/banking_icon.svg',
          ),
        ],
      ),
      PointEarningSegmentUiModel(
        title: 'Enhance your App Experience ',
        subtitle: 'Your app experience',
        pointEarningRuleList: [
          PointEarningRuleUiModel(
            type: RewardPointRuleType.LOCATION_PERMISSION,
            title: 'Allow location access',
            subtitle: 'Get personalized weather.',
            iconPath: 'assets/icons/ic_location.svg',
          ),
          PointEarningRuleUiModel(
            type: RewardPointRuleType.CAMERA_ACCESS,
            title: 'Allow camera access',
            subtitle: 'Upload your profile photo.',
            iconPath: 'assets/icons/ic_camera.svg',
          ),
        ],
      ),
      PointEarningSegmentUiModel(
        title: 'Share & Grow with the GloriFi Community',
        subtitle: 'Grow the GloriFi Community',
        pointEarningRuleList: [
          PointEarningRuleUiModel(
            type: RewardPointRuleType.SHARE_GLORIFI_APP,
            title: 'Share the GloriFi App',
            subtitle: 'Send to friends and family.',
            iconPath: 'assets/icons/ic_share.svg',
          ),
        ],
      ),
    ];
    _pointEarningSegmentListController(pointEarningSegmentList);
  }

  void _prepareEarnPointActionFinancialAccount() {
    var earnPointActionList = [
      PointEarningRuleUiModel(
        type: RewardPointRuleType.SET_UP_DIRECT_DEPOSIT,
        title: 'Earn 2% rewards points',
        subtitle:
            'With the GloriFi Cartridge Brass World Elite Mastercard® credit card.',
        iconPath: 'assets/icons/coin.svg',
      ),
      PointEarningRuleUiModel(
        type: RewardPointRuleType.EARN_POINTS_WHILE_YOU_SAVE,
        title: 'Earn 1.5% rewards points',
        subtitle:
            'With no annual fee with all other GloriFi Mastercard® credit cards.  ',
        iconPath: 'assets/icons/coin.svg',
      ),
    ];
    _earnPointActionFinancialAccount(earnPointActionList);
  }
}
