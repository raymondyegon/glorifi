import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/base_event_listening_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/model/last_linked_account_info_model.dart';

class LastLinkedAccountController extends BaseEventListeningController
    with StateMixin {
  final _dataHelper = DataHelperImpl.instance;

  Rx<LastLinkedAccountInfoModel> accountData = LastLinkedAccountInfoModel().obs;

  Uint8List? img;

  var error = "".obs;

  Future<void> getLastAddedAccountInfo() async {
    final response = await _dataHelper.apiHelper.getLastLinkedAccountInfo();
    response.fold((error) => change(setError(error), status: RxStatus.error()),
        (success) => change(setData(success), status: RxStatus.success()));
  }

  setError(CustomException error) {
    this.error.value = error.errorMessage;
  }

  setData(LastLinkedAccountInfoModel data) {
    if (accountData.value.institutionLogo != data.institutionLogo) {
      accountData.value = data;
      if (data.institutionLogo != null && data.institutionLogo != '') {
        img = base64Decode(data.institutionLogo!);
        refresh();
      }
    }
  }

  @override
  void onAccountsChanged(_){
    getLastAddedAccountInfo();
  }
}
