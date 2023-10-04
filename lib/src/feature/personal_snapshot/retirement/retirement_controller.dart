// ignore_for_file: avoid_print
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';

import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_model.dart';

class RetirementController extends GetxController with StateMixin {
  final _apiHelper = DataHelperImpl.instance.apiHelper;
  final memberId = Get.find<ProfileController>().userProfile.memberId;

  var indexNumber = 0.obs;
  var cardNumber = 2.obs;
  var totalFund = 0.0.obs;
  var employerSponsoredTotal = 0.0.obs;
  var individualTotal = 0.0.obs;

  List<RetirementAccount> employerSponsoredAccounts = [];
  List<RetirementAccount> individualSponsoredAccounts = [];

  var loading = false.obs;

  @override
  void onInit() {
    mapData();
    super.onInit();
  }

  Future<RetirementModel?> getRetirementSavingsData() async {
    try {
      final res = await _apiHelper.getRetirementSavings();
      return RetirementModel.fromJson(res['data'] as Map<String, dynamic>);
    } catch (e) {
      print(e);
      return null;
    }
  }

  mapData() async {
    loading.value = true;
    var retResponse = await getRetirementSavingsData();

    if (retResponse == null) {
      change(() {}, status: RxStatus.error());
      return;
    }

    var accounts = retResponse.accounts;
    List employSponsorList = accounts.employerSponsoredAccounts;
    List individualSponsorList = accounts.individualAccounts;

    print('json list');
    print(employSponsorList);
    print(individualSponsorList);
    loading.value = false;
    change(() {}, status: RxStatus.success());
    totalFund.value = retResponse.current;
    employerSponsoredTotal.value = retResponse.employeeSponsored;
    individualTotal.value = retResponse.indivRetirementAccounts;

    employerSponsoredAccounts = accounts.employerSponsoredAccounts;
    individualSponsoredAccounts = accounts.individualAccounts;

    loading.value = false;
  }
}
