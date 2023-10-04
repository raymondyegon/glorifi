import 'dart:core';

import 'package:get/get.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/model/support/faq_categories_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

import '../../core/data_helper.dart';
import '../../feature/support/support_models/support_main_page_content_model.dart';
import '../../routes/app_pages.dart';
import '../../utils/login_status/login_status.dart';

class FAQCategoriesController extends BaseController {
  bool isBottomSheet = false;
  bool isLoggedIn = false;
  List<SupportMainContentModel> supportContents = SupportDummyList.list;

  RxList faqCategories = [].obs;

  RxString answer = ''.obs;
  RxString title = ''.obs;
  RxBool loading = false.obs;

  RxList navigationStack = [0].obs;

  RxList list = [].obs;
  RxList orderedList = [
    if (FeatureFlagManager.BankingSupportEnabled) 'Banking',
    if (FeatureFlagManager.InsuranceSupportEnabled) 'Insurance',
    if (FeatureFlagManager.MortgageSupportEnabled) 'Mortgage',
    if (FeatureFlagManager.GeneralQuestionsSupportEnabled) 'General Questions'
  ].obs;
  final dataImpl = DataHelperImpl.instance;

  //this variable is used for indexing purpose.
  Map<String, String> librariesMap = {};

  /**==============================================================*/
  String? selectedCategoryTitle, selectedCategoryKey;
  String? selectedSupportCategoryTitle, selectedSupportMethod;
  String? name, email, phone, memberID;
  String? routingKey, finalIntent;
  Map<String, dynamic> webViewArguments = {};
  Map<String, dynamic> emailSupportRequestParams = {};

  /**==============================================================*/

  RxList questions = [].obs;

  String selectedQuestion = '', selectedAnswer = '';

  /// [initFromFAQListingScreen] Here true means controller initializing is happening
  /// from FAQListingPage and hence we need to fetch FAQ list from init itself.
  bool initFromFAQListingScreen = false;

  FAQCategoriesController({
    // [isBottomSheet] Will be used on FAQ Listing page , to get the selectedCategory
    this.isBottomSheet = false,
    this.initFromFAQListingScreen = false,
    this.selectedCategoryKey,
  });

  @override
  void onInit() {
    CheckLoginStatus.isLoggedIn().then((value) async {
      if (value) {
        isLoggedIn = value;
      }
    });
    if (initFromFAQListingScreen) {
      getFAQQuestions();
    } else
      getFAQCategories();

    super.onInit();
  }

  String setAsset(String assetName) {
    for (final item in assetMap.entries) {
      if (assetName.contains(item.key)) {
        return item.value;
      }
    }
    return assetMap["general"];
  }

  getFaqList() async {
    Map<String, dynamic> categories =
        await DataHelperImpl.instance.cacheHelper.getFAQCategories();

    categories.forEach(
      (key, value) {
        list.add(key);
      },
    );

    orderedList.forEach(
      (element) {
        if (list.contains(element.toString().toLowerCase())) {
          list.remove(element.toString().toLowerCase());
        }
      },
    );

    //This will have to be removed to include items not in the orderedList
    if (list.isNotEmpty) {
      list.clear();
    }
    list.insertAll(0, orderedList);

    loading.value = false;

    update();
  }

  Future<void> getFAQCategories() async {
    loading.value = true;
    update();

    final response = await dataImpl.apiHelper.getGemsTree();

    response.fold((l) {
      apiExceptionMessage(l.errorCode);
    }, (r) {
      List<FAQCategories> parents = r.data;

      cacheCategories(parents);

      faqCategories.value = parents;
    });

    getFaqList();
  }

  List getLibraryIDs() {
    List libraryIDs = faqCategories.map((e) => e.key).toList();
    return libraryIDs;
  }

  void cacheCategories(List<FAQCategories> parents) {
    // List<Map<String, String>> categoryMap = parents.map((e) => {e.title, e.key}).cast<Map<String, String>>().toList();
    Map<String, String> result = Map.fromEntries(parents.map((value) {
      librariesMap[value.key!] = value.title ?? '';
      return MapEntry(value.title?.toLowerCase() ?? 'title', value.key!);
    }));

    DataHelperImpl.instance.cacheHelper.saveFAQCategories(result);
  }

  void navigateToListingPage(int index) {
    faqCategories.forEach((element) {
      if (element.title
          .toString()
          .toLowerCase()
          .contains(list[index].toString().toLowerCase())) {
        navigateToListingPageWithData(element.title, element.key);
      }
    });
  }

  void navigateToListingPageWithData(String title, String key) {
    if (selectedCategoryKey != key) {
      questions.clear();
    }

    selectedCategoryTitle = title;
    selectedCategoryKey = key;

    getFAQQuestions();

    if (!isBottomSheet) {
      Get.toNamed(
        Routes.faqQuestionsListingScreen,
        parameters: {'title': title, 'key': key},
      );
    } else {
      navigationStack.insert(0, FAQListingScreen);
    }
  }

  Map<String, dynamic> assetMap = {
    "banking": "assets/icons/banking_icon.svg",
    "insurance": "assets/icons/insurance_icon.svg",
    "mortgage": "assets/icons/mortgage_icon.svg",
    "credit": "assets/icons/credit_card_icon.svg",
    "general": "assets/icons/general_icon.svg",
  };

  Future<void> getFAQQuestions() async {
    final dataImpl = DataHelperImpl.instance;
    loading.value = true;
    update();

    if (selectedCategoryKey == null) {
      final response = await dataImpl.apiHelper.getGemsTree();

      response.fold((l) {}, (r) {
        List<FAQCategories> parents = r.data;

        cacheCategories(parents);

        faqCategories.value = parents;

        parents.forEach((element) {
          if (element.title?.toLowerCase() == selectedCategoryTitle) {
            selectedCategoryKey = element.key;
          }
        });
      });
    }

    Map<String, dynamic> body = {
      "from": 0,
      "size": 100,
      "sortOrder": "ASC",
      "gemTypes": ["FAQ"],
      "parentId": selectedCategoryKey
    };

    final response = await dataImpl.apiHelper.getGems(body);

    response.fold((l) {}, (r) {
      questions.value = r.hits;
    });
    loading.value = false;
    update();
  }

  // this method will be utilized when controller is created from FAQListingPage. That happens when FAQListing page is directly accessed from
  // inside product pages .
  setLibraryKeyandTitle(String? libraryKey, String? title) {
    if (libraryKey != null && libraryKey.isNotEmpty) {
      selectedCategoryKey = libraryKey;
    }

    if (title != null && title.isNotEmpty) {
      selectedCategoryTitle = title;
    }
  }
}
