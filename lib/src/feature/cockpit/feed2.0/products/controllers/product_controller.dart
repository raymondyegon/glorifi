import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class ProductsController extends BaseController {
  final _apiHelper = DataHelperImpl.instance.apiHelper;

  RxInt tabIndex = 0.obs;
  RxInt sliderIndex = 0.obs;
  RxInt creditCardsSliderIndex = 0.obs;
  RxInt insuranceOptionsSliderIndex = 0.obs;
  var productValue = ProductModel(type: '').obs;

  final requestedCreditCard = false.obs;
  final requestedMortgage = false.obs;
  final requestedBanking = false.obs;
  final requestedInsurance = false.obs;

  List<ProductModel> productPageDetail = [
    ProductModel.creditCard(),
    ProductModel.mortgage(),
    ProductModel.banking(),
    ProductModel.insurance(),
  ];
  List<String> tabList = ["Credit Cards", "Mortgages", "Banking", "Insurance"];
  @override
  void onInit() async {
    productValue.value = productPageDetail[tabIndex.value];
    _setInitialValues();
    super.onInit();
  }

  _setInitialValues() async {
    // TODO: Fetch from cache helper
    final _dataHelper = DataHelperImpl.instance;
    requestedCreditCard.value = await _dataHelper.cacheHelper
        .getRequestedEarlyAccessForProduct('creditCard');
    requestedMortgage.value = await _dataHelper.cacheHelper
        .getRequestedEarlyAccessForProduct('mortgage');
    requestedBanking.value = await _dataHelper.cacheHelper
        .getRequestedEarlyAccessForProduct('banking');
    requestedInsurance.value = await _dataHelper.cacheHelper
        .getRequestedEarlyAccessForProduct('insurance');
  }

  changeTab(int index) {
    tabIndex.value = index;
    productValue.value = productPageDetail[index];
    sliderIndex.value = 0;
    creditCardsSliderIndex.value = 0;
    insuranceOptionsSliderIndex.value = 0;
  }

  Future<bool> onEarlyAccessTap() async {
    try {
      final response =
          await _apiHelper.requestEarlyAccess(productValue.value.type);
      if (response['success'] == true) {
        _updateRequestedStatus();
      }

      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }

  _updateRequestedStatus() {
    final _dataHelper = DataHelperImpl.instance;
    switch (productValue.value.type) {
      case "creditCard":
        _dataHelper.cacheHelper.requestedEarlyAccessForProduct('creditCard');
        requestedCreditCard.value = true;
        return;
      case "mortgage":
        _dataHelper.cacheHelper.requestedEarlyAccessForProduct('mortgage');
        requestedMortgage.value = true;
        return;
      case "banking":
        _dataHelper.cacheHelper.requestedEarlyAccessForProduct('banking');
        requestedBanking.value = true;
        return;
      case "insurance":
        _dataHelper.cacheHelper.requestedEarlyAccessForProduct('insurance');
        requestedInsurance.value = true;
        return;
    }
  }

  bool get requestedStatus {
    switch (productValue.value.type) {
      case "creditCard":
        return requestedCreditCard.value;
      case "mortgage":
        return requestedMortgage.value;
      case "banking":
        return requestedBanking.value;
      case "insurance":
        return requestedInsurance.value;
      default:
        return false;
    }
  }
}
