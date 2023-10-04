import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/common_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/address_autocomplete/address_autocomplete_widget.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../widgets/loading/glorifi_spinner.dart';

class SelectAddressScreen extends GetView<HomeValueController> {
  SelectAddressScreen({Key? key}) : super(key: key);

  final Widget loader = Container(
    color: GlorifiColors.white,
    child: Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        child: GlorifiSpinner(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final AddressFlowTypeScreenArguments? args = Get.arguments;
    String appBarTitle = 'Add Address';
    bool isEdit = args != null && args.flowType == AddressFlowType.edit;
    if (isEdit) {
      appBarTitle = 'Edit Address';
    }

    final _formKey = GlobalKey<FormState>();
    final spaceOnTwo = 15.0.h;

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.superLightGrey,
          appBar: GlorifiAppBar(
            title: appBarTitle,
            textStyle: bodySemiBold18Primary(
              color: GlorifiColors.ebonyBlue,
            ),
          ),
          body: SafeArea(
            child: Obx(
              () => controller.onSubmit.isTrue || controller.loading.isTrue
                  ? loader
                  : Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(15.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: controller.loading.isFalse &&
                                  (sizingInfo.isDesktop || sizingInfo.isTablet),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 30.h,
                                  bottom: 30.h,
                                  left: sizingInfo.isDesktop ? 50.w : 30.w,
                                ),
                                child: Text(
                                  appBarTitle,
                                  style: headlineBold30Secondary(
                                    color: GlorifiColors.biscayBlue,
                                  ),
                                ),
                              ),
                            ),
                            AdaptiveGrid(
                              children: [
                                AdaptiveGridItem(
                                  desktop: 60,
                                  webMobile: 100,
                                  tablet: 100,
                                  nativeMobile: 100,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: (sizingInfo.isDesktop ||
                                              sizingInfo.isTablet)
                                          ? 50.0.w
                                          : 0.0,
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 36.h,
                                          ),
                                          AddressAutocompleteWidget(
                                            controller:
                                                controller.streetController,
                                            onAutocompleteTap:
                                                (PlaceDetailModel place) {
                                              controller.fillForm(place);
                                            },
                                            label: 'Street Address',
                                            error:
                                                'Please Enter Street Address',
                                          ),
                                          SizedBox(
                                            height: spaceOnTwo,
                                          ),
                                          GlorifiTextField(
                                            textEditingController:
                                                controller.aptNumberController,
                                            label:
                                                'Apt / Suite Number (Optional)',
                                            validator: GlorifiTextField
                                                .optionalValidator,
                                          ),
                                          SizedBox(
                                            height: spaceOnTwo,
                                          ),
                                          GlorifiTextField(
                                            textEditingController:
                                                controller.cityController,
                                            label: 'City',
                                            validator: GlorifiTextField
                                                .requiredFieldValidator(
                                                    'your city'),
                                          ),
                                          SizedBox(
                                            height: spaceOnTwo,
                                          ),
                                          TwoColumnGloriFiSilverField(
                                            textField1: Obx(() => StateDropDown(
                                                  value: controller
                                                              .state.value ==
                                                          ""
                                                      ? null
                                                      : controller.state.value,
                                                  onChanged: (value) {
                                                    controller.state(value);
                                                  },
                                                )),
                                            textField2: GlorifiTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              textEditingController:
                                                  controller.zipController,
                                              label: 'ZIP Code',
                                              validator: GlorifiTextField
                                                  .requiredFieldValidator(
                                                      'your zip code'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 27.0.h,
                                          ),
                                          Obx(
                                            () => glorifiButton(
                                              bgColor: controller
                                                      .onSubmit.isTrue
                                                  ? GlorifiColors.greyBgColor
                                                  : GlorifiColors
                                                      .primaryDarkButtonColor,
                                              text: 'Save',
                                              onTap: () => {
                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    controller.onSubmit.isFalse)
                                                  {
                                                    controller.onSubmittedAddress(
                                                        args != null
                                                            ? args.flowType
                                                            : AddressFlowType
                                                                .add,
                                                        sizingInfo
                                                                .isNativeMobile ||
                                                            sizingInfo
                                                                .isWebMobile),
                                                  }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
