import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/analytics.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/personal_snapshot/link_data_flow/link_data_flow_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/compare/compare_value_dialog.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/model/address_data.dart';
import 'package:glorifi/src/model/personal_snapshot/home_value_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

import '../feature/personal_snapshot/compare/compare_value.dart';
import '../utils/glorifi_colors.dart';
import 'account_flags_controller.dart';

class HomeValueController extends GetxController {
  final AccountFlagsController _accountFlagsController =
      Get.put(AccountFlagsController());

  final RxBool loading = false.obs;

  final onSubmit = false.obs;
  var primaryAddress = false.obs;
  var streetAddress = ''.obs;
  var cityState = ''.obs;

  var streetController = TextEditingController();
  var aptNumberController = TextEditingController();
  var cityController = TextEditingController();
  var zipController = TextEditingController();

  RxBool fetchingAddressData = false.obs;

  Rxn<String> state = Rxn<String>();

  final _dataHelper = DataHelperImpl.instance;

  Rx<HomeValueModel> homeValueDetail = HomeValueModel().obs;

  Rx<String> statusApi = ''.obs;

  @override
  void onInit() {
    fetchAddressData();
    _initializeListener();
    super.onInit();
  }

  loadChartData(String idAddress, {showLoading = true}) async {
    if (showLoading) {
      loading.value = true;
    }
    if (idAddress.isNotEmpty) {
      final dynamic response = await _dataHelper.apiHelper.getHomeValueAddress(
        idAddress,
      );

      await response.fold((l) {
        statusApi('500');
        loading.value = false;
      }, (data) {
        statusApi('success');
        HomeValueModel homeValueDetailApi =
            HomeValueModel.fromJson(data['data']);

        homeValueDetail(homeValueDetailApi);

        if (data['error'] != null) {
          showErrorToast(data['error']);
        }
        loading.value = false;
      });
      update();
    }
  }

  fetchAddressData() async {
    if (_accountFlagsController.flags.value.hasAddr) {
      try {
        fetchingAddressData(true);
        final response = await _dataHelper.apiHelper.fetchAddress();
        await response.fold(
          (l) {
            Log.error(l.errorMessage);
            apiExceptionMessage(l.errorCode, toast: true);
          },
          (res) async {
            if (res != null && res['success']) {
              statusApi('success');
              AddressData addressData =
                  AddressData.fromJson(res['data']['Address']);
              String street =
                  '${addressData.addrAddressLine1} ${addressData.addrAddressLine2}';
              String cityStateZip =
                  '${addressData.addrCity}, ${addressData.addrState}, ${addressData.addrPostalCode}';

              primaryAddress.value = addressData.addrType == 99;
              streetAddress.value = street;
              cityState.value = cityStateZip;

              //set value for controller...
              streetController.text = addressData.addrAddressLine1;
              aptNumberController.text = addressData.addrAddressLine2;
              cityController.text = addressData.addrCity;
              zipController.text = addressData.addrPostalCode;
              state.value = addressData.addrState;
              await loadChartData('${addressData.addrId}');
            }
          },
        );
      } catch (e) {
        // showErrorToast('Something went wrong');
        statusApi('500');
      } finally {
        fetchingAddressData(false);
      }
    }
  }

  void _initializeListener(){
    _accountFlagsController.didLoad.listen((p0) {
      fetchAddressData();
    });
  }

  onSubmittedAddress(AddressFlowType flowType, bool isDevice) async {
    onSubmit(true);
    Map<String, dynamic> mMap = Map();
    mMap['addr_address_line1'] = streetController.text.trim();
    mMap['addr_address_line2'] = aptNumberController.text.trim();
    mMap['addr_city'] = cityController.text.trim();
    mMap['addr_state'] = state.value ?? '';
    mMap['addr_country'] = 'US';
    mMap['addr_postal_code'] = zipController.text.trim();
    mMap['addr_type'] = '99';
    mMap['is_preferred_addr'] = true;
    final response = await _dataHelper.apiHelper.savePrimaryAddress(mMap);
    await response.fold(
      (l) {
        onSubmit(false);
        Log.error(l.errorMessage);

        apiExceptionMessage(l.errorCode);
        // showErrorToast(l.errorMessage);
      },
      (res) async {
        if (res != null && res['success']) {
          AddressData addressData = AddressData.fromJson({
            ...res['data'],
            "addr_type": int.parse(mMap['addr_type']),
          });

          final String street =
              '${addressData.addrAddressLine1} ${addressData.addrAddressLine2}';
          final String cityStateZip =
              '${addressData.addrCity}, ${addressData.addrState}, ${addressData.addrPostalCode}';

          primaryAddress.value = addressData.addrType == 99;
          streetAddress.value = street;
          cityState.value = cityStateZip;

          await loadChartData('${addressData.addrId}');

          if (isDevice)
            Get.offAndToNamed(
              Routes.successAddressScreen,
              arguments: AddressFlowTypeScreenArguments(flowType: flowType),
            );
          else
            _successDialog(
                AddressFlowTypeScreenArguments(flowType: flowType), isDevice);
        }
      },
    );

    onSubmit(false);
  }

  goToDetailsScreen() {
    Get.toNamed(Routes.homeValueDetailsScreen);
  }

  goToAddressScreen(AddressFlowType flowType) {
    if (!primaryAddress.value && streetAddress.isNotEmpty)
      Get.toNamed(
        Routes.successAddressScreen,
        arguments: AddressFlowTypeScreenArguments(flowType: flowType),
      );
    else {
      Get.toNamed(
        Routes.selectAddressScreen,
        arguments: AddressFlowTypeScreenArguments(flowType: flowType),
      );
    }
  }

  goToEditAddressScreen() {
    Get.toNamed(Routes.selectAddressScreen,
        arguments:
            AddressFlowTypeScreenArguments(flowType: AddressFlowType.edit));
  }

  goToSelectAddressScreen() {
    Get.toNamed(
      Routes.selectAddressScreen,
    );
  }

  openComparison(bool isDevice) {
    if (isDevice) {
      Get.bottomSheet(
        CompareValueScreen(
          gloriFiCompareState: GloriFiCompareType.homeValue,
          member: homeValueDetail.value.value.toString(),
        ),
        barrierColor: GlorifiColors.barrierColor,
        isScrollControlled: true,
        isDismissible: false,
      );
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '',
        content: CompareValueDialog(
          gloriFiCompareState: GloriFiCompareType.homeValue,
          cardId: homeValueDetail.value.cardId,
          member: homeValueDetail.value.value.toString(),
        ),
        radius: 5.r,
      );
    }
  }

  _successDialog(AddressFlowTypeScreenArguments args, bool isDevice) {
    LinkDataFlowController().accountFlagsController.flags.value.hasAddr = true;
    Get.offNamed(Routes.homeValueDetailsScreen);
    final text = args.flowType != AddressFlowType.edit ? 'Added' : 'Edited';
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.r))),
              scrollable: true,
              title: null,
              backgroundColor: GlorifiColors.midnightBlue,
              content: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(isDevice ? 15.sp : 80.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/successful.svg',
                      width: 35.w,
                    ),
                    SizedBox(height: 50.0.h),
                    Text(
                      'Your Home Address Was $text!',
                      textAlign: TextAlign.center,
                      style: headlineRegular26Secondary(
                        color: GlorifiColors.white,
                      ),
                    ),
                    SizedBox(height: 80.0.h),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(GlorifiColors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 70.0.w, vertical: 15.0.h),
                        child: Text(
                          'Close',
                          style: bodyBold18Primary(
                            color: GlorifiColors.ebonyBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void fillForm(PlaceDetailModel place) {
    state.value = place.state;
    streetController.text =
        '${place.streetNumber != '' ? '${place.streetNumber} ' : ''}${place.route}';
    cityController.text = place.city;
    zipController.text = place.zipCode;
  }

  void updateFlags() {
    final SnapshotController snapshotController = Get.find();
    snapshotController.loadData(showLoading: false);
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    streetController.dispose();
    aptNumberController.dispose();
    cityController.dispose();
    zipController.dispose();
    updateFlags();
    super.onClose();
  }
}
