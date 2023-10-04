import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/comparison_feature_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/common_widget.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

import '../../../widgets/loading/glorifi_spinner.dart';

class EditCompareValue extends GetView<ComparisonFeatureController> {
  const EditCompareValue({Key? key}) : super(key: key);
  final Widget loader = const Expanded(
    child: Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: GlorifiSpinner(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TwoColumnGloriFiSilverField(
            textField1: GlorifiTextField(
              textCapitalization: TextCapitalization.words,
                  textEditingController: controller.cityController,
                  label: "City",
                  validator: GlorifiTextField.requiredFieldValidator('your city'),
            ),
            textField2: Obx(() => StateDropDown(
                  value: controller.selectedState.value,
                  onChanged: (value) {
                    controller.selectedState.value = value;
                  },
                )),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          GlorifiDropDown(
              label: "Marital Status",
              items: controller.maritalStatus,
              value: controller.selectMaritalStatus,
              onChanged: (value) {
                controller.selectMaritalStatus = value.toString();
              }),
          SizedBox(
            height: 20.0.h,
          ),
          GlorifiTextField(
            textEditingController: TextEditingController(text: controller.ageRange.value),
            label: "Age Range",
            enabled: false,
          ),
          SizedBox(
            height: 40.0.h,
          ),
          glorifiButton(
            text: 'Save',
            onTap: () => {
              if (_formKey.currentState!.validate())
                {
                  controller.saveComparison(),
                }
            },
          ),
        ],
      ),
    );
  }
}
