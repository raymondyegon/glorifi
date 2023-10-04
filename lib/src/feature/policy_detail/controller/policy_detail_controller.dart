import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/policy_detail/model/policy_detail_data.dart';
import 'package:glorifi/src/feature/policy_detail/model/policy_detail_response.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/insurance_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';

import '../../../utils/support/support_navigation_helper.dart';

class PolicyDetailController extends BaseController {
  late String policyType;
  late String id;
  late final String name;
  final Rxn<PolicyDetailData> policyDetailData = Rxn<PolicyDetailData>();

  @override
  void onInit() async {
    id = Get.arguments["policyId"] as String;
    name = Get.arguments["policyName"] as String;
    policyType = Get.arguments["policyType"] as String;
    super.onInit();
    getPolicyDetails();
  }

  Future<void> navigateToFAQ() async {
    String category = "Insurance";
    SupportNavigationHelper.navigateToList(category);
  }

  Future<void> submitClaim() async {
    Get.toNamed(Routes.submitClaimScreen);
  }

  Future<void> navigateToPolicyDetails() async {
    Get.toNamed(Routes.policyDocuments);
  }

  Future<void> getPolicyDetails() async {
    try {
      change(null, status: RxStatus.loading());
      PolicyDetailResponse response = await InsuranceService()
          .getPolicyDetail(id: id) as PolicyDetailResponse;
      policyDetailData.value = response.data;
    } catch (e) {
      Log.error(e);
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}
