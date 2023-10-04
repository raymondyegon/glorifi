import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/mortgage/model/state_data_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

import '../../../core/data_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../services/mortgage_service.dart';
import '../../credit_card/model/notify_data.dart';
import '../widgets/email_notify_success.dart';

class MortgagePreApplyController extends BaseController {
  RxList<ProductsAvailable> mortgageStateData = RxList<ProductsAvailable>();
  final isLoading = true.obs;
  final isNotifyLoading = false.obs;
  late String selectedState;
  bool isValidState = false;
  final _dataHelper = DataHelperImpl.instance;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> getMortgagesStates(bool isFromCreditCard) async {
    try {
      isLoading(true);
      StateDataResponse response =
          await MortgageService().getMortgageStateData(isFromCreditCard ? "CREDIT CARD" : "MORTGAGE") as StateDataResponse;
      response.productsAvailable
          .sort((a, b) => a.stateName.compareTo(b.stateName));
      mortgageStateData.addAll(response.productsAvailable);
    } finally {
      isLoading(false);
    }
  }

  void checkValidState(bool? isFromCreditCard) async {
    try {
      if (isValidState) {
        List<ProductsAvailable> selectedStates = mortgageStateData
            .where((p0) =>
                p0.stateName.toLowerCase() == selectedState.toLowerCase())
            .toList();
        if (selectedStates.isNotEmpty) {
          ProductsAvailable productsAvailable = selectedStates.first;
          if (productsAvailable.productAvailable) {
            if(isFromCreditCard != null){
              navigateToStateUnavailableCreditCard(true, selectedStates.first.stateName);
            } else {
              Get.toNamed(Routes.connectBlendSso,
                  parameters: {'title': 'Mortgage'})
                  ?.then((value) => Get.back(result: true));
            }
          } else {
            if(isFromCreditCard != null){
              navigateToStateUnavailableCreditCard(false, selectedStates.first.stateName);
            } else {
              navigateToStateUnavailable(selectedState);
            }
          }
        } else {
          showErrorMessage();
        }
      } else {
        showErrorMessage();
      }
    } catch (e) {
      Log.debug(e.toString());
    }
  }

  Future<Map<String, dynamic>?> notifyEmailStatus(String product, String stateName) async {
    try {
      isNotifyLoading(true);
      final response = await _dataHelper.apiHelper.notifyEmailStatus(product, stateName);
      late NotifyData br;
      response.fold((l) => null, (r) => {br = NotifyData.fromJson(r)});
      if (br.data?.Notified != null) {
        if (br.data?.Notified == true) {
          Get.off(
            EmailNotifySuccess(
              onTap: () {
                Get.back();
              },
              showLegalName: true,
            ),
          );
        } else {
          navigateToStateUnavailable(stateName);
        }
      }
    } finally {
      isNotifyLoading(false);
    }
  }

  void validSelectedState(String state) {
    if (mortgageStateData
        .where(
          (p0) => p0.stateName
              .toLowerCase()
              .trim()
              .contains(state.toLowerCase().trim()),
        )
        .isNotEmpty) {
      isValidState = true;
      selectedState = state;
    } else {
      isValidState = false;
    }
  }

  void navigateToStateUnavailable(String stateName) {
    Get.offNamed(Routes.mortgageUnavailable, arguments: [{"stateName" : stateName}]);
  }

  void navigateToStateUnavailableCreditCard(bool stateAvailability, String stateName) {
    Get.toNamed(Routes.creditCardUnavailable, arguments: [
      {"stateAvailability": stateAvailability, "stateName" : stateName}
    ]);
  }

  void showErrorMessage() {
    showErrorToast("Invalid State Selected");
  }
}
