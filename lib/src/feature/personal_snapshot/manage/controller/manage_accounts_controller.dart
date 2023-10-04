import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/common_contained_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/linked_institutions_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class ManageAccountsController extends GetxController with StateMixin {
  final _dataHelper = DataHelperImpl.instance;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  RxBool unlinkingInProgress = false.obs;
  RxList<LinkedInstitutionModel> institutions =
      RxList<LinkedInstitutionModel>();

  bool get isDismissible => unlinkingInProgress.isFalse;

  Future<void> loadData({bool showLoading = false}) async {
    if (showLoading) {
      change(() {}, status: RxStatus.loading());
    }
    final response = await _dataHelper.apiHelper.getLinkedPlaidAccounts();
    response.fold(
        (error) => change(() {}, status: RxStatus.error()),
        // ignore: unnecessary_lambdas
        (success) => setInstitutions(success));
  }

  setInstitutions(LinkedInstitutionsModel _institutionsModel) {
    institutions.value = _institutionsModel.institutions;
    if (institutions.length == 0) {
      change(() {}, status: RxStatus.empty());
    } else {
      change(() {}, status: RxStatus.success());
    }
  }

  Future<void> unlinkAccount({required LinkedInstitutionModel institution}) async {
    try {
      change(() {}, status: RxStatus.loading());
      final response =
          await _dataHelper.apiHelper.unlinkPlaidInstitution(institution.id);
      response.fold((error) {
        showErrorToast('Something went wrong, please try again later.');
      }, (_response) {
        if (_response.success == true) {
          loadData();
          Get.back();
          Get.toNamed(Routes.unlinkAccountSuccessScreen,
              arguments: institution.accounts.length);
          Get.find<ProfileController>().refreshProfile();
        } else {
          showErrorToast('Something went wrong, please try again later.');
        }
      });
    } catch (_) {
      showErrorToast('Something went wrong, please try again later.');
    } finally {
      change(() {}, status: RxStatus.success());
    }
  }

  void unlinkInstitution(LinkedInstitutionModel institution) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 55,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 24,
            right: 24,
            bottom: 41,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you sure you want to remove ${institution.accounts.length > 1 ? 'these accounts' : 'this account'}? You can add ${institution.accounts.length > 1 ? 'them' : 'it'} again later.',
                    style: smallRegular16Primary(
                        color: GlorifiColors.textColorBlack),
                  ),
                  SizedBox(height: 50.h),
                  Obx(
                    () => WillPopScope(
                      onWillPop: () async =>
                          unlinkingInProgress.isTrue ? false : true,
                      child: CommonContainedButton(
                        isLoading: unlinkingInProgress.isTrue,
                        text:
                            'Unlink Account${institution.accounts.length > 1 ? 's' : ''}',
                        onTap: () async {
                          try {
                            unlinkingInProgress.value = true;
                            final response = await _dataHelper.apiHelper
                                .unlinkPlaidInstitution(institution.id);
                            response.fold((error) {
                              showErrorToast(
                                  'Something went wrong, please try again later.');
                            }, (_response) {
                              if (_response.success == true) {
                                loadData();
                                Get.back();
                                Get.toNamed(Routes.unlinkAccountSuccessScreen,
                                    arguments: institution.accounts.length);
                                Get.find<ProfileController>().refreshProfile();
                              } else {
                                showErrorToast(
                                    'Something went wrong, please try again later.');
                              }
                            });
                          } catch (_) {
                            showErrorToast(
                                'Something went wrong, please try again later.');
                          } finally {
                            unlinkingInProgress.value = false;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      isDismissible: isDismissible,
    );
  }
}
