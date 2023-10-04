import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/highlight_model_prefabs.dart';
import 'package:glorifi/src/services/highlight_service.dart';

class HighlightController extends GetxController {
  final highlights = {}.obs;
  RxBool _loadingComplete = false.obs;
  bool get loadingComplete => _loadingComplete.value;

  var cockpitController = Get.find<CockpitController>();
  var carouselController = Get.find<CarouselController>();
  RxInt current = 0.obs;

  int get count => highlights.keys.length;
  int get numPages => (count / 2).ceil(); // we show 2 cards per page
  bool get showPlaceHolders => count < 2;

  @override
  void onInit() async {
    _setInitialHighlights();
    // Get.find<ProfileController>().userProfileObs.listen((userProfile) {
    //   HighlightModel model;
    //   if (userProfile.joinDate
    //       .add(Duration(days: 1))
    //       .isBefore(DateTime.now())) {
    //     model = HighlightPrefabs.GlorifiStory;
    //   } else {
    //     List models = [
    //       HighlightPrefabs.SeeAllArticles,
    //       HighlightPrefabs.SeeAllVideos,
    //     ];
    //     model = (models..shuffle())[0];
    //   }
    //   highlights[HighlightType.content] = model;
    // });
    super.onInit();
  }

  HighlightModel getHighlightByIndex(int index) {
    // sorts by HighlightType
    List keys = highlights.keys.toList();
    keys.sort((a, b) => a.index.compareTo(b.index));

    return highlights[keys[index]];
  }

  updatePlaidCard() async {
    _setBankAccount();
    highlights[HighlightType.insights] = HighlightPrefabs.Insights;
  }

  _setProductStatus() async {
    // highlights[HighlightType.applicationStatus2] =
    //     HighlightPrefabs.MortgageStatus;
    // return;
    // TODO: just for DEMO *******************************************************

    final model = await HighlightService().getApplicationStatus();
    if (model == null) {
      return;
    }

    if (model.mortgageUpdated) {
      highlights[HighlightType.applicationStatus2] =
          HighlightPrefabs.MortgageStatus;
    }
    if (model.insuranceUpdated) {
      highlights[HighlightType.applicationStatus1] =
          HighlightPrefabs.InsuranceStatus;
    }
    if (model.bankingUpdated) {
      highlights[HighlightType.applicationStatus] =
          HighlightPrefabs.BankingStatus;
    }
  }

  // TODO: add apiCall
  _setSecondaryTask() {
    highlights[HighlightType.secondaryTask] = HighlightPrefabs.UpdateProfile;
  }

  _setInviteFriend() {
    highlights[HighlightType.referral] = HighlightPrefabs.InviteFriend;
  }

  _setBankAccount() async {
    HighlightModel? model = await HighlightService().getBankAccountHighlight();
    if (model != null) {
      highlights[HighlightType.bankAccount] = model;
    }
  }

  // _setCreditScore() async {
  //   HighlightModel? model = await HighlightService().getCreditScoreHighlight();
  //   if (model != null) {
  //     highlights[HighlightType.creditScore] = model;
  //   }
  // }

  _setProducts() async {
    HighlightModel? model = await HighlightService().getProductsHighlight();
    if (model != null) {
      highlights[HighlightType.products] = model;
    }
  }

  _setInsights() async {
    HighlightModel? model = await HighlightService().getInsightsHighlight();
    if (model != null) {
      highlights[HighlightType.insights] = model;
    }
  }

  _setContent() {
    List models = [
      // HighlightPrefabs.SeeAllArticles,
      // HighlightPrefabs.SeeAllVideos,
    ];
    highlights[HighlightType.content] = (models..shuffle())[0];
  }

  _setInitialHighlights() async {
    await _setProductStatus();
    await _setBankAccount();
    //await _setCreditScore();
    await _setInsights();
    _setInviteFriend();
    _setContent();
    _setSecondaryTask();
    await _setProducts();
    _loadingComplete(true);

    // TODO: add apiCalls
    await Future.delayed(const Duration(seconds: 3), () {});
    highlights[HighlightType.applicationStatus2] =
        HighlightPrefabs.MortgageStatus;
    highlights[HighlightType.bankAccount] = HighlightPrefabs.LinkBankAccount;
    //highlights[HighlightType.creditScore] = HighlightPrefabs.CheckCreditScore;
    highlights[HighlightType.insights] = HighlightPrefabs.LinkInsights;
    _setInviteFriend();
    // highlights[HighlightType.content] = HighlightPrefabs.GlorifiStory;
    _setSecondaryTask();
    highlights[HighlightType.products] = HighlightPrefabs.PetInsurance;

    _loadingComplete(true);

    // await _setProductStatus();
    // await _setBankAccount();
    // await _setCreditScore();
    // await _setInsights();
    // _setInviteFriend();
    // _setContent();
    // _setSecondaryTask();
    // await _setProducts();
    // _loadingComplete(true);
  }

  void isDraggable(bool isScrolled) {
    cockpitController.setIsDraggable(isScrolled);
  }
}
