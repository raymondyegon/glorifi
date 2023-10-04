import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/value/controller/value_controller.dart';
import 'package:glorifi/src/feature/onboard/value/widget/see_all_product.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/feature/onboard/widgets/onboarding_background_video.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ValueScreen extends GetView<ValueController> {
  static const routeName = '/valuescreen';

  ValueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Get.height * 0.18),
            child: Transform.scale(
              child: const OnboardingBackgroundVideo(),
              scale: 1.4,
            ),
          ),
          GradientOverlayContainer(
            stops: [0.3, 1],
            child: Container(height: Get.height + 10, width: Get.width),
          ),
          SafeArea(child: _pageContent())
        ],
      ),
    );
  }

  _onTapSignIn() {
    Get.toNamed(Routes.login);
  }

  _onTapCreateAccount() {
    Get.toNamed(Routes.createProfilePlus);
  }

  _onTapSeeAllProducts() {
    Get.toNamed(Routes.ALL_PRODUCTS);
  }

  Widget _pageContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ValuePager(
            contents: controller.contents,
            onPageChange: (page) => controller.updatePage(page),
          ),
        ),
        SizedBox(height: GlorifiValues.margin_36),
        SeeAllProductsWidget(onTap: _onTapSeeAllProducts),
        SizedBox(height: GlorifiValues.smallMargin),
        Obx(() => ValuePagerIndicator(
              pageCount: controller.contents.length,
              currentIndex: controller.pagerPage,
            )),
        SizedBox(height: GlorifiValues.margin_48),
        _createAccountButton(),
        SizedBox(height: GlorifiValues.largeMargin),
        _alreadyMemberWidget(),
        SizedBox(height: GlorifiValues.margin_32),
      ],
    );
  }

  Widget _alreadyMemberWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: GlorifiValues.largeMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already a member? ', style: sansNormalStyle),
          Ripple(
            onTap: _onTapSignIn,
            child: Text(
              'Sign In',
              style: sansBoldStyle.copyWith(
                height: 1.36,
                shadows: [Shadow(color: Colors.white, offset: Offset(0, -1.2))],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: GlorifiValues.largeMargin,
      ),
      width: Get.width,
      height: GlorifiValues.defaultButtonHeight,
      child: PrimaryButton(
        onTap: _onTapCreateAccount,
        height: 64.h,
        title: TextConstants.joinTheMovement,
        textColor: GlorifiColors.midnightBlueColor,
        fontSize: 18.sp,
      ),
    );
  }
}
