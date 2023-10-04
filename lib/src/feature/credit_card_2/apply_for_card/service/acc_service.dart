import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/api/api_helper.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/application_status_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';

class ACCService extends GetxService {
  final ApiHelper _apiHelper = DataHelperImpl.instance.apiHelper;
  final ProfileController _profileController = Get.find();

  String? platformUserId;
  String? applicationId;

  Future<void> createDeserveUser() async {
    Map<String, dynamic> data = {"email": _profileController.userProfile.email};
    final res = await _apiHelper.createDeserveUser(data);
    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {
        try {
          platformUserId = r["id"];
        } catch (e, stackTrace) {
          Log.error(e.toString());
          Log.error(stackTrace.toString());
        }
      },
    );
  }

  Future<void> createApplicationId() async {
    Map<String, dynamic> data = {
      "platform_user_id": platformUserId,
      "channel": "MOBILE"
    };
    final res = await _apiHelper.createCCApplication(data);
    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {
        applicationId = r["application_id"];
      },
    );
  }

  Future<void> getApplicationStatus({
    bool shouldInvokeCallback = false,
    Function? callback,
  }) async {
    final res = await _apiHelper.getACCApplicationStatus(applicationId);

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {
        try {
          Get.find<ACCApplicationStatusModel>().data =
              ApplicationStatusData.fromJson(r["data"]);
          Log.debug(Get.find<ACCApplicationStatusModel>().data!.toJson());
          if (shouldInvokeCallback) {
            callback!();
          }
        } catch (e, stackTrace) {
          Log.debug(e.toString());
          Log.debug(stackTrace.toString());
        }
      },
    );
  }

  Future<void> validateBasicInformation(Map<String, dynamic> data) async {
    final res = await _apiHelper.validateBasicInformation(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<void> validateContactInformation(Map<String, dynamic> data) async {
    final res = await _apiHelper.validateContactInformation(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<void> validateAddressInformation(Map<String, dynamic> data) async {
    final res = await _apiHelper.validateAddressInformation(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<dynamic> tokenizationSSN(Map<String, dynamic> data) async {
    final res = await _apiHelper.tokenizationSSN(
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {
        Log.debug(r.toString());
        return r['data']['value'];
      },
    );
  }

  Future<void> validateEmploymentStatus(Map<String, dynamic> data) async {
    final res = await _apiHelper.validateEmploymentStatus(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<void> validateExpenseInformation(Map<String, dynamic> data) async {
    final res = await _apiHelper.validateExpenseInformation(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<void> updateApplicantData() async {
    final res = await _apiHelper.updateApplicantData(
      applicationId,
      Get.find<ACCMemberApplicationModel>().toJsonForUpdateApplicant(),
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<void> updateCreditPullConsent() async {
    Map<String, dynamic> data = {
      "credit_pull_consent": true,
      "cha_accepted": true,
    };
    final res = await _apiHelper.accUpdatePullConsent(
      applicationId,
      data,
    );

    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {},
    );
  }

  Future<String> acceptCardHolderAgreement() async {
    Map<String, dynamic> data = {
      "product_acceptance": true,
    };
    final res = await _apiHelper.acceptCardHolderAgreement(
      applicationId,
      data,
    );
    return res.fold(
      (l) {
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }
}
