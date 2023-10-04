import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/core/analytics.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/plaid/plaid_success_screen.dart';
import 'package:glorifi/src/model/plaid_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:plaid_flutter/plaid_flutter.dart';


enum PlaidFlowType { regular, oaoFunding, funding, creditCard, transferLinking, checking, savings }

class PlaidController extends GetxController with StateMixin {
  LinkTokenConfiguration? linkTokenConfiguration;
  var response_link_token;
  RxBool isLoading = false.obs;
  PlaidFlowType? _flowType;

  Rx<PlaidModel> plaidModel = PlaidModel().obs;
  var error = "".obs;

  Future<PlaidModel> getPlaidLinkToken() async {
    try {
      isLoading.value = true;
      var response;
      switch (_flowType) {
        case PlaidFlowType.funding:
        case PlaidFlowType.oaoFunding:
        case PlaidFlowType.transferLinking:
          response =
              await DataHelperImpl.instance.apiHelper.getAuthPlaidLinkToken();
          break;
        default:
          response =
              await DataHelperImpl.instance.apiHelper.getPlaidLinkToken();
          break;
      }
      PlaidModel success = await response.fold(
        (error) => change(setError(error), status: RxStatus.error()),
        (success) {
          change(setPlaidModelModel(success), status: RxStatus.success());
          return success;
        },
      );
      return success;
    } catch (e) {
      showErrorToast('Connecting to plaid failed, please try again later');
      Log.error(e.toString());
      return PlaidModel(data: null, success: false);
    } finally {
      isLoading.value = false;
    }
  }

  ///Always use this function to open plaid!
  Future openPlaid(
      {PlaidFlowType flowType = PlaidFlowType.regular, Function? onTap}) async {
    _flowType = flowType;

    await getPlaidLinkToken().then((response) async {
      if (response.success && response.data != null) {
        PlaidLink.open(
          configuration: LinkTokenConfiguration(
            token: response.data!.link_token!,
          ),
        );
      }
    });
  }

  setPlaidModelModel(PlaidModel model) {
    plaidModel.value = model;
    response_link_token = plaidModel.value.data!.link_token;

    linkTokenConfiguration = LinkTokenConfiguration(
      token: response_link_token,
    );

    Log.debug("Response Link Token: $response_link_token");
    PlaidLink.onSuccess(_onSuccessCallback);
    PlaidLink.onEvent(_onEventCallback);
    PlaidLink.onExit(_onExitCallback);
  }

  setError(CustomException error) {
    this.error.value = error.errorMessage;
  }

  void openInputScreen() {
    Get.toNamed(Routes.enableCreditScoreStep1Name);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    Log.debug('from on success callback function');

    switch (_flowType) {
      case PlaidFlowType.funding:
        passPublicToken(publicToken,
            accountsIds: [...metadata.accounts.map((e) => e.id).toList()]);

        Get.toNamed(Routes.plaidSuccessScreen,
            arguments:
                PlaidSuccessScreenArguments(type: PlaidFlowType.funding));
        break;
      //Specifically for the oao_fund_your_plaid_screen.dart
      case PlaidFlowType.oaoFunding:
      case PlaidFlowType.transferLinking:
        passPublicToken(publicToken,
            accountsIds: [...metadata.accounts.map((e) => e.id).toList()]);
        // final oaoController = Get.find<OAOController>();
        // oaoController.selectedFundingAccount.value = null;

        // oaoController.fetchFundingAccounts();
        Get.toNamed(Routes.plaidSuccessScreen,
            arguments:
                PlaidSuccessScreenArguments(type: _flowType!));
        break;
      default:

        passPublicToken(publicToken);

        Get.put(AccountFlagsController()).flags.value.hasPlaidLinkedAcct = true;

        if (_flowType != null) {
          Get.toNamed(Routes.plaidSuccessScreen,
              arguments: PlaidSuccessScreenArguments(type: _flowType!));
        } else {
          Get.toNamed(
            Routes.plaidSuccessScreen,
          );
        }
      
        break;
    }
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    Log.debug("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    Log.debug("onExit metadata: ${metadata.description()}");

    if (error != null) {
      Log.debug("onExit error: ${error.description()}");
    }
  }

  passPublicToken(token, {List accountsIds = const []}) async {
    final _dataHelper = DataHelperImpl.instance;
    late var response;
    try {
      switch (_flowType) {
        case PlaidFlowType.funding:
          response = await _dataHelper.apiHelper
              .saveFundingAccountToken(token, accountsIds);
          break;
        case PlaidFlowType.oaoFunding:
        case PlaidFlowType.transferLinking:
          response = await _dataHelper.apiHelper
              .saveFundingAccountToken(token, accountsIds);
          break;
        default:
          response = await _dataHelper.apiHelper.savePlaidToken(token);
          break;
      }

      change(response, status: RxStatus.success());
      return response;
    } catch (e) {
      Log.error("from passPublicToken error");
      Log.error(e);
      change(e, status: RxStatus.error());
    }
  }
}
