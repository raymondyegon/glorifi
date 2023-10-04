import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/contact_support_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../../../font_style_global.dart';

class CreateProfileVerificationFailed extends StatelessWidget {
  CreateProfileVerificationFailed({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(ContactSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.midnightBlue,
      body: _pageBody(),
    );
  }

  Widget _pageBody() {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return CreateProfileContainer(
        percent: 1,
        title: (sizingInfo.isDesktop || sizingInfo.isTablet)
            ? CreateProfileInfo.unableToCreateAccountTitle
            : "",
        text: (sizingInfo.isDesktop || sizingInfo.isTablet)
            ? CreateProfileInfo.unableToCreateAccountSubtitle
            : "",
        pageTitles: createProfileTitles,
        progressBarActiveTitle: createProfileTitles.last,
        child: (sizingInfo.isDesktop || sizingInfo.isTablet)
            ? _webWidget()
            : _mobileWidget(),
      );
    });
  }

  Widget _webWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _warningIcon(),
        SizedBox(
          height: 82.h,
        ),
        _getContactSupportButton(),
      ],
    );
  }

  Widget _mobileWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 105.h,
        ),
        _warningIcon(),
        SizedBox(
          height: 80.h,
        ),
        Text(
          CreateProfileInfo.unableToCreateAccountTitle,
          style: headlineRegular31Secondary(color: GlorifiColors.white),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          CreateProfileInfo.unableToCreateAccountSubtitle,
          style: smallRegular16Primary(color: GlorifiColors.white),
        ),
        SizedBox(
          height: 82.h,
        ),
        _getContactSupportButton(),
      ],
    );
  }

  Widget _getContactSupportButton() {
    return PrimaryButton(
      height: 64.h,
      title: TextConstants.contactSupport,
      fontSize: 18.sp,
      textColor: GlorifiColors.midnightBlueColor,
      icon: SvgPicture.asset(
        GlorifiAssets.icMessage,
        width: 20.sp,
        height: 19.sp,
      ).paddingOnly(left: 10.w),
      hasRightArrow: false,
      iconColor: GlorifiColors.biscayBlue,
      onTap: _onTapContactSupport,
    );
  }

  _onTapContactSupport() async {
    await controller.callConversationEmailApi('general');

    //todo mode should be modal
    controller.navigateToContactSupport('general');
  }

  _warningIcon() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        GlorifiAssets.error,
        color: GlorifiColors.cornflowerBlue,
        width: 180.w,
        height: 150.h,
      ),
    );
  }
}
