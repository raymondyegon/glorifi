import 'package:glorifi/src/routes/app_pages.dart';

class SupportMainContentModel {
  final String? label;
  final String? asset;
  final String? routeName;

  SupportMainContentModel({
    this.label,
    this.asset,
    this.routeName,
  });
}

class SupportDummyList {
  static final List<SupportMainContentModel> list = [
    SupportMainContentModel(
      label: 'Banking',
      asset: 'assets/icons/ic_banking.svg',
      routeName: Routes.faqCategoriesListingScreen,
    ),
    SupportMainContentModel(
      label: 'Insurance',
      asset: 'assets/icons/ic_insurance.svg',
      routeName: Routes.faqCategoriesListingScreen,
    ),
    SupportMainContentModel(
      label: 'General',
      asset: 'assets/icons/ic_banking.svg',
      routeName: Routes.faqCategoriesListingScreen,
    ),
    SupportMainContentModel(
      label: 'Credit Card',
      asset: 'assets/icons/clipboard_list.svg',
      routeName: Routes.faqCategoriesListingScreen,
    ),
    SupportMainContentModel(
      label: 'Mortgage',
      asset: 'assets/icons/ic_mortgage.svg',
      routeName: Routes.faqCategoriesListingScreen,
    ),
  ];
}
