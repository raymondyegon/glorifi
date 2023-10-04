import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_details_response_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_response_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/bundle_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class BundleController extends BaseController {
  static const bundleTypeKey = 'bundleTypeKey';
  static const bundleScreenTag = 'bundleScreenTag';
  late final BundleType bundleType;
  final Rx<PageState> _pageStateController = Rx(PageState.DEFAULT);
  var title = ''.obs;
  var assetImage = ''.obs;
  var earnText = ''.obs;
  final Rx<BundleDetailsResponseModels> _bundleDetailsController =
  Rx(BundleDetailsResponseModels());

  BundleDetailsResponseModels get bundleDetails => _bundleDetailsController.value;

  PageState get pageState => _pageStateController.value;

  final RxList<BundleModel> _bundleListController = RxList.empty();

  List<BundleModel> get bundleList => _bundleListController.toList();

  @override
  void onInit() {
    bundleType = Get.arguments?[bundleTypeKey] ?? BundleType.None;
    // Log.info("bundleType $bundleType");
    _getImage(bundleType);
    _getTitle(bundleType);
    _getEarnText(bundleType);
    _fetchBundleDetails(bundleType);
    super.onInit();
  }

  void _getTitle(BundleType bundleType) {
    switch (bundleType) {
      case BundleType.Protect:
        title.value = 'Protect';
        break;
      case BundleType.HomeFront:
        title.value = 'Homefront';
        break;
      case BundleType.Heroes:
        title.value = 'Heroes';
        break;

      default:
        title.value = 'None';
    }
  }

  void _getImage(BundleType bundleType) {
    switch (bundleType) {
      case BundleType.Protect:
        assetImage.value = GlorifiAssets.bundle_protect_bg;
        break;
      case BundleType.HomeFront:
        assetImage.value = GlorifiAssets.bundle_home_front_bg;
        break;
      case BundleType.Heroes:
        assetImage.value = GlorifiAssets.bundle_hero_bg;
        break;

      default:
        assetImage.value = GlorifiAssets.bundle_details_card_bg;
    }
  }

  void _getEarnText(BundleType bundleType) {
    switch (bundleType) {
      case BundleType.Protect:
        earnText.value = ' 7,500 points ';
        break;
      case BundleType.HomeFront:
        earnText.value = ' 7,500 points ';
        break;
      case BundleType.Heroes:
        earnText.value = ' 7,500 points ';
        break;

      default:
        title.value = '';
    }
  }

  // _fetchBundleDetails(BundleType bundleType) {
  //   switch (bundleType) {
  //     case BundleType.Heroes:
  //       cardList.value = <String>[
  //         "Open a Checking Account",
  //         "Open a Savings Account",
  //         "Get notified about Credit Cards",
  //       ];
  //       break;
  //
  //     case BundleType.HomeFront:
  //       cardList.value = <String>[
  //         "Checking or Savings Account",
  //         "Home Insurance",
  //         "Auto Insurance",
  //         "Mortgage",
  //         "Get notified about Credit Cards",
  //       ];
  //       break;
  //
  //     case BundleType.Protect:
  //       cardList.value = <String>[
  //         "Checking or Savings Account",
  //         "Home Insurance",
  //         "Auto Insurance",
  //         "Get notified about Credit Cards",
  //       ];
  //       break;
  //
  //     default:
  //       cardList.value = [];
  //   }
  // }

  void _getBundlesData(String tag) async {
    BundleDetailsResponseModels? model = await BundleService().getBundleDetails(tag);

    if (model != null) {
      _pageStateController(PageState.SUCCESS);
      _bundleDetailsController(model);
    } else {
      _pageStateController(PageState.ERROR);
    }
  }

  _fetchBundleDetails(BundleType bundleType) async {
    _pageStateController(PageState.LOADING);

    switch (bundleType) {
      case BundleType.Heroes:
        _getBundlesData('heroes');
        break;

      case BundleType.HomeFront:
        _getBundlesData('homefront');
        break;

      case BundleType.Protect:
        _getBundlesData('protect');
        break;

      default:
        _pageStateController(PageState.DEFAULT);
        break;
    }
  }

  fetchBundles() async {
    if (FeatureFlagManager.bundlesEnabled == false) {
      return;
    }
    BundleResponseModel? model = await BundleService().getBundles();

    if (model != null) {
      _bundleListController(model.bundleList);
    }
  }

  navigateToTask(int index) {
    // This is a temporary solution to convert any routes from the API to the real route in app
    final apiRoute = bundleDetails.tasks![index].route!;
    final realRoute = _routeMapping[apiRoute];

    // FIXME: So grimey, but arguments are required when navigating to banking.
    Get.offNamed(realRoute ?? apiRoute, arguments: {
      "accountType": AccountType.NONE,
      "connected": false,
      "plaidAccount": false,
    });
  }

  Map<String, String> get _routeMapping => {
        "checkingAccount": Routes.openBankAccount,
        "savingsAccount": Routes.openBankAccount,
        "depositAccount": Routes.openBankAccount,
        // TODO: Instead of sending to the list, deep link directly to the webview flow
        "homeInsurance": Routes.insuranceCategoryList,
        "autoInsurance": Routes.insuranceCategoryList,
        "creditCard": Routes.creditCardComingSoonScreen,
        "mortgageApplication": Routes.mortgage
      };
}
