import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class EBSWireInstructions extends GetView<EBSController> {
  const EBSWireInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return EBSContainer(
        title: 'Wire Instructions',
        children: _content(),
        showSettings: false,
      );
    });
  }

  List<Widget> _content() {
    return [
      SizedBox(height: 37.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 43.h),
          decoration: BoxDecoration(
              color: GlorifiColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: GlorifiColors.black.withOpacity(0.05),
                  blurRadius: 16,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SingleTextItem(
                title: 'Bank information:',
                bottomMargin: 16.h,
              ),
              Divider(
                color: GlorifiColors.borderGrey,
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SingleTextItem(
                      title: 'Bank Name:',
                      description:
                          '“Stearns Bank 4191 2nd St. S \nSt. Cloud, MN  56301 (320) 253-6607”',
                    ),
                    _SingleTextItem(
                      title: 'ABA/RT Number:',
                      description: '091910455',
                    ),
                    _SingleTextItem(
                      title: 'Beneficiary Account Name:',
                      description: 'GloriFi Financial',
                    ),
                    _SingleTextItem(
                      title: 'Beneficiary Account Number:',
                      description: controller.details.accountNumber,
                    ),
                    _SingleTextItem(
                      title: 'Beneficiary Address:',
                      description: controller.userAddress.value.formatted,
                    ),
                    _SingleTextItem(
                      title: 'Originator to Beneficiary Info:',
                      description: _beneficiaryInfo(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  String _beneficiaryInfo() {
    ProfileController _profileController = Get.find<ProfileController>();
    return '${_profileController.getUserFullName()} \nMember ID: ${_profileController.userProfile.memberId}';
  }
}

class _SingleTextItem extends StatelessWidget {
  final String title;
  final String? description;
  final double bottomMargin;

  const _SingleTextItem({Key? key, required this.title, this.description, this.bottomMargin = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: captionBold14Primary(
            color: GlorifiColors.ebonyBlue,
          ),
        ),
        if (description != null)
          Text(
            description!,
            style: captionRegular14Primary(
              color: GlorifiColors.ebonyBlue,
            ),
          ),
        SizedBox(
          height: bottomMargin.h,
        ),
      ],
    );
  }
}
