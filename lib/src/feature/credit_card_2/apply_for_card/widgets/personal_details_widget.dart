import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/member_application_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class PersonalDetailsWidget extends StatelessWidget {
  const PersonalDetailsWidget({
    Key? key,
    required this.accMemberApplicationModel,
    
  }) : super(key: key);

  final ACCMemberApplicationModel accMemberApplicationModel;

  @override
  Widget build(BuildContext context) {
    Demographic _demographic = accMemberApplicationModel.demographic!;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 24.w,
      ),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 55,
            spreadRadius: 0,
            color: GlorifiColors.black.withOpacity(.10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(TextConstants.yourDetails),
          _subTitle(),
          SizedBox(
            height: 16.h,
          ),
          _listTile(
            title: TextConstants.name,
            subTitle: _demographic.fullName,
          ),
          _listTile(
            title: TextConstants.dob,
            subTitle: _demographic.getDisplayFormattedDOB,
          ),
          _listTile(
            title: TextConstants.email,
            subTitle: _demographic.email!,
          ),
          _listTile(
            title: TextConstants.phoneNumber,
            subTitle: _demographic.getDisplayFormattedPhoneNumber,
          ),
          _listTile(
            title: TextConstants.permanentAddress,
            subTitle: _demographic.getDisplayFormattedPermanentAddress,
          ),
          Visibility(
            visible: _demographic.shouldShowMailingAddress,
            child: _listTile(
              title: TextConstants.mailingAddress,
              subTitle: _demographic.getDisplayFormattedMailingAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile({
    required String title,
    required String subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smallSemiBold16Primary(
            color: GlorifiColors.primaryDarkButtonColor,
          ),
        ),
        Text(
          subTitle,
          style: captionRegular14Primary(
            color: GlorifiColors.darkGrey80,
          ),
        ).marginOnly(top: 2.h),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: leadBold24Primary(
        color: GlorifiColors.primaryDarkButtonColor,
      ),
    ).paddingOnly(bottom: 10.h);
  }

  Widget _subTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: TextConstants.contact,
            style: xSmallSemiBold12Primary(color: GlorifiColors.dateDarkGrey),
          ),
          TextSpan(
            text: TextConstants.support,
            style: xSmallBold12Primary(color: GlorifiColors.gradientDarkBlue),
          ),
          TextSpan(
            text: TextConstants.contactDetails,
            style: xSmallSemiBold12Primary(color: GlorifiColors.dateDarkGrey),
          ),
        ],
      ),
    );
  }
}
