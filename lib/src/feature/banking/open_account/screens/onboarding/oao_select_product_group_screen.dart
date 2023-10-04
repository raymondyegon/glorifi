import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_select_product_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/feature/banking/widgets/outlined_button_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

// Step 1 of 6
// https://app.asana.com/0/1202239119682092/1202240186732663/f
class OAOSelectProductGroupScreen extends GetView<OAOController> {
  const OAOSelectProductGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, //Status bar icon/text color
      child: AdaptiveScaffold(
        body: Obx(() => controller.loading.value
            ? Center(child: GlorifiSpinner())
            : _pager(context)),
      ),
    );
  }

  String dateNow() {
    var now = DateTime.now();
    return DateFormat.yMd().format(now);
  }

  Widget _pager(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10.h,
              left: 15.w,
              bottom: 10.h),
          child: _backButton(),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 71.h),
            child: Center(
              child: Container(
                width: 720,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change the way you bank for good',
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.w400,
                        color: GlorifiColors.cornflowerBlue,
                      ).copyWith(height: 40 / 31),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'With GloriFi, you get all the benefits of big tech, within a community that values … values.',
                      style: captionRegular14Primary(
                        color: GlorifiColors.cornflowerBlue,
                      ).copyWith(height: 24 / 14),
                    ),
                    SizedBox(height: 20.h),
                    if (controller.checkingProducts.length > 0)
                      _ProductCard(
                        image: GlorifiAssets.checking_card_image,
                        title: 'GloriFi Checking with Interest',
                        description:
                            'Our premier checking is everything you’d expect from a bank that believes in you as much as it believes in doing what’s right.  ',
                        content: [
                          _CheckMarkItem(text: r'$0 Minimum Deposit'),
                          _CheckMarkItem(text: r'$0 Maintenance Fees'),
                          _CheckMarkItem(
                              text: 'Access to 90,000 No-Fee ATMs\n worldwide'),
                          SizedBox(height: 22.h),
                          _PercentageItem(
                              superScript: "\u00B2",
                              value: controller.checkingApyDouble,
                              description: 'Annual Percentage Yield'),
                          SizedBox(height: 6.h),
                        ],
                        buttonText: 'Open a Checking Account',
                        onTap: () {
                          // Mark that we are doing the checking product. Continue to Personal Details collection
                          // Only one option
                          controller.onBeginApplication(
                              controller.checkingProducts.first);
                        },
                      ),
                    if (controller.savingsProducts.length > 0)
                      _ProductCard(
                        image: GlorifiAssets.saving_card_image,
                        title: 'GloriFi Savings',
                        description:
                            'Make your money work for you with rates that are four times the national average.',
                        content: [
                          _CheckMarkItem(text: r'$0 Minimum Deposits'),
                          _CheckMarkItem(text: r'$0 Maintenance Fees'),
                          _CheckMarkItem(text: 'Competitive Rates'),
                          SizedBox(height: 22.h),
                          _PercentageItem(
                              superScript: "\u00B3",
                              value: controller.savingApyDouble,
                              description: 'Annual Percentage Yield'),
                          SizedBox(height: 6.h),
                        ],
                        buttonText: 'Open a Savings Account',
                        onTap: () {
                          // Mark that we are doing the savings product. Continue to Personal Details collection
                          controller.onBeginApplication(
                              controller.savingsProducts.first);
                        },
                      ),
                    _ProductCard(
                      image: GlorifiAssets.deposit_card_image,
                      title: 'GloriFi Certificate of Deposit',
                      description:
                          'Looking for certainty in uncertain times with competitive interest rates? GloriFi offers certificates of deposit at various term lengths: ' +
                              '${controller.cdProducts.map((element) => element.term).toList().join(", ")}.\u2074',
                      content: [
                        _CheckMarkItem(
                            text: '\$${minCDDeposit} Minimum Deposits'),
                        _CheckMarkItem(text: r'$0 Maintenance Fees'),
                      ],
                      buttonText: 'Open a Certificate of Deposit',
                      onTap: () {
                        controller.application.selectedProduct = null;
                        Get.to(() => OAOProductSelection());
                      },
                    ),
                    SizedBox(height: 23.h),
                    OAOFooterNote(
                      customText: TextSpan(children: [
                        TextSpan(
                            text: "\u00B9GloriFi is a financial technology company, not a bank. GloriFi Checking, GloriFi Savings, and GloriFi Certificate of Deposit (CD) are provided by Stearns Bank, N.A., Member FDIC." +
                                "\n\n²${controller.checkingApy} APY on balances up to \$15,000.00 and 0.5% APY on balances over \$15,000.01. Rates are current as of ${dateNow()}. Additional information can be found on our "),
                        textSpanHyperLink(
                            text: "rate sheet",
                            url: "https://glorifi.com/rates/"),
                        TextSpan(
                            text:
                                "\n\n³Variable interest rates are subject to change at any time after the account is opened. Annual Percentage Yield {APY} is current as of ${dateNow()}. Fees could reduce the earnings on the account. Additional information can be found on our "),
                        textSpanHyperLink(
                            text: "rate sheet",
                            url: "https://glorifi.com/rates/"),
                        TextSpan(
                            text:
                                "\n\n⁴Annual Percentage Yield (APY) is accurate as of ${dateNow()} and applies to the initial term of a new CD. The minimum balance required to open a CD is \$${minCDDeposit}. Fees could reduce earnings on the account. A penalty may be imposed for early withdrawal. Rates are not guaranteed until the account is opened and fully funded.")
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _backButton() {
    return Material(
      color: GlorifiColors.greyF3,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: Get.back,
        child: Container(
          width: 30,
          height: 30,
          child: Center(
            child: SvgPicture.asset(
              GlorifiAssets.caret_1,
              color: GlorifiColors.midnightBlue,
              height: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final List<Widget> content;
  final String buttonText;
  final void Function()? onTap;

  const _ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.content,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 26.h,
      ),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
              color: GlorifiColors.black.withOpacity(0.1), blurRadius: 55),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        child: Column(children: [
          Image.asset(
            image,
            width: double.infinity,
            height: 160,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 51.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      GlorifiAssets.glorifiLogo,
                                      height: 13,
                                    ),
                                    _sm(),
                                  ]),
                              SizedBox(height: 10.h),
                              Text(title + " \u00B9",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: GlorifiColors.cornflowerBlue,
                                  )).paddingOnly(bottom: 5),
                              Text(
                                description,
                                style: captionRegular14Primary(
                                  color: GlorifiColors.ebonyBlue,
                                ).copyWith(height: 24 / 14),
                              ),
                              SizedBox(height: 20.h),
                            ]),
                      ),
                      ...content
                    ]),
              ),
              SizedBox(height: 14.h),
              GlorifiOutlinedButton(
                onTap: onTap,
                height: 64.h,
                title: buttonText,
                fontSize: 18.sp,
                textColor: GlorifiColors.cornflowerBlue,
                borderWidth: 2,
                borderColor: GlorifiColors.primaryButtonIconColor,
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

Widget _sm() => Text(
      " SM",
      style: TextStyle(
          fontSize: 7,
          height: 0.8,
          fontWeight: FontWeight.w700,
          color: GlorifiColors.darkBlueColor),
    );

class _CheckMarkItem extends StatelessWidget {
  final String text;

  const _CheckMarkItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            GlorifiAssets.checkmark,
            height: 22,
            color: GlorifiColors.greenTint[600],
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: captionBold14Primary(
              color: GlorifiColors.cornflowerBlue,
            ),
          )
        ],
      ),
    );
  }
}

class _PercentageItem extends StatelessWidget {
  final double value;
  final String description;
  final String superScript;

  const _PercentageItem({
    Key? key,
    required this.value,
    required this.description,
    required this.superScript,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value%$superScript',
            style: leadBold24Secondary(
              color: GlorifiColors.cornflowerBlue,
            ),
          ),
          Text(
            description,
            style: xSmallRegular12Primary(color: GlorifiColors.darkGrey80),
          ),
        ],
      ),
    );
  }
}
