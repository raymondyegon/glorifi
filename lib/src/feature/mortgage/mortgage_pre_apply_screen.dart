import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/controllers/mortgage_pre_apply_controller.dart';
import 'package:glorifi/src/feature/mortgage/model/state_data_model.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../font_style_global.dart';
import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../widgets/containers/gradient_overlay_container.dart';
import '../../widgets/loading/glorifi_spinner.dart';

SizedBox addPaddingWhenKeyboardAppears() {
  final viewInsets = EdgeInsets.fromWindowPadding(
    WidgetsBinding.instance!.window.viewInsets,
    WidgetsBinding.instance!.window.devicePixelRatio,
  );

  final bottomOffset = viewInsets.bottom;
  const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
  final isNeedPadding = bottomOffset != hiddenKeyboard;

  return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
}

class MortgagePreApplyScreen extends StatelessWidget {
  MortgagePreApplyScreen({
    Key? key,
    this.isFromCreditCard,
  }) : super(key: key);

  final Widget loader = Container(
    color: GlorifiColors.white,
    child: Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        child: GlorifiSpinner(),
      ),
    ),
  );

  final bool? isFromCreditCard;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MortgagePreApplyController());
    controller.getMortgagesStates(isFromCreditCard != null ? true : false);
    final TextEditingController _typeAheadController = TextEditingController();

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.isDesktop) {
          return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.productsBgWhite,
            body: Obx(
              () => controller.isLoading.isTrue
                  ? loader
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            color: GlorifiColors.lighterGrey,
                            padding: EdgeInsets.symmetric(
                              horizontal: sizingInfo.isDesktop
                                  ? 200.w
                                  : sizingInfo.isTablet
                                      ? 34.5.w
                                      : 24.5.w,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 1024),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Before You Apply",
                                    style: headlineRegular31Secondary(
                                      color: GlorifiColors.cornflowerBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/images/mortgage_background_web.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GradientOverlayContainer(
                                stops: [0.2, 1],
                                colors: [
                                  GlorifiColors.defaultGradientStartColor,
                                  GlorifiColors.defaultGradientEndColor,
                                ],
                                child: Container(
                                  height: Get.height + 10,
                                  width: Get.width,
                                ),
                              ),
                              Positioned(
                                top: 200,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sizingInfo.isDesktop
                                        ? 200.w
                                        : sizingInfo.isTablet
                                            ? 34.5.w
                                            : 24.5.w,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 1024),
                                    child: AdaptiveGrid(
                                      children: [
                                        AdaptiveGridItem(
                                          desktop: 55,
                                          tablet: 100,
                                          nativeMobile: 100,
                                          webMobile: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Which state are you looking to purchase or refinance in?",
                                                style:
                                                    headlineRegular31Secondary(
                                                  color: GlorifiColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AdaptiveGridItem(
                                          desktop: 40,
                                          webMobile: 100,
                                          tablet: 100,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: sizingInfo.isDesktop
                                                  ? 32.w
                                                  : 0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "State",
                                                  style:
                                                      xSmallSemiBold12Primary(
                                                    color: GlorifiColors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: GlorifiColors
                                                          .bermudaGray,
                                                    ),
                                                    color: GlorifiColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  child: generateAutoComplete(
                                                      controller),
                                                ),
                                                SizedBox(
                                                  height: 32.h,
                                                ),
                                                PrimaryDarkButton(
                                                  title: "Apply Now",
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 60.h,
                                                  textColor: GlorifiColors
                                                      .midnightBlueColor,
                                                  icon: SvgPicture.asset(
                                                    GlorifiAssets.rightArrow,
                                                    color: GlorifiColors
                                                        .primaryButtonIconColor,
                                                  ),
                                                  primaryColor:
                                                      GlorifiColors.white,
                                                  onTap: () {
                                                    controller
                                                        .checkValidState(isFromCreditCard);
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                      FocusNode(),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 38.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.w),
                                                  child: InkWell(
                                                    onTap: shareApp,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Applying with a Co-Applicant?",
                                                              style:
                                                                  smallBold16Primary(
                                                                color:
                                                                    GlorifiColors
                                                                        .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              "Invite them to be a GloriFi member.",
                                                              style:
                                                                  smallRegular16Primary(
                                                                color:
                                                                    GlorifiColors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SvgPicture.asset(
                                                          "assets/icons/share_icon.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Animo Mortgage Company LLC  d/b/a GloriFi Mortgage // NMLS #2267438",
                                                  style: tinyRegular8Primary(
                                                    color: GlorifiColors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
          );
        } else {
          return AdaptiveScaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: GlorifiColors.productsBgWhite,
            appBar: isFromCreditCard == null
                ? GlorifiAppBar(
                    title: 'Before You Apply',
                  )
                : AppBar(
                    toolbarHeight: 0,
                    backgroundColor: Colors.transparent,
                  ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    isFromCreditCard != null ? Positioned.fill(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              GlorifiAssets.creditCardStateBackground,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: GlorifiColors.midnightBlue,
                            ),
                          ),
                        ],
                      ),
                    ) : Offstage(),
                    Container(
                      decoration: isFromCreditCard == null ? BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            isFromCreditCard == null ? GlorifiAssets.mortgageBackground : GlorifiAssets.creditCardStateBackground,
                          ),
                        ),
                      ) : BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            GlorifiColors.midnightBlue.withOpacity(0.0),
                            GlorifiColors.midnightBlue.withOpacity(0.5),
                            GlorifiColors.midnightBlue.withOpacity(0.8),
                            GlorifiColors.midnightBlue,
                            GlorifiColors.midnightBlue,
                          ],
                          stops: [0.0, 0.3, 0.5, 0.6, 1.0],
                        ),
                      ),
                      child: Obx(
                        () => controller.isLoading.isTrue ||
                                controller.isLoading.isTrue
                            ? loader
                            : SingleChildScrollView(
                                reverse: true,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width,
                                    //minHeight: screenHeight,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              GlorifiColors.whiteBlue
                                                  .withOpacity(0.0),
                                              GlorifiColors.midnightBlue,
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                sizingInfo.isNativeMobile
                                                    ? 24.h
                                                    : 32.h,
                                            vertical: sizingInfo.isNativeMobile
                                                ? 20.w
                                                : 40.w,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                isFromCreditCard == null
                                                    ? "Which state are you looking to purchase or refinance in?"
                                                    : "What State are you looking to get a credit card in?",
                                                style: isFromCreditCard == null
                                                    ? headlineRegular31Secondary(
                                                        color:
                                                            GlorifiColors.white,
                                                      )
                                                    : headlineRegular26Primary(
                                                        color:
                                                            GlorifiColors.white,
                                                      ),
                                              ),
                                              SizedBox(
                                                height: 40.h,
                                              ),
                                              Text(
                                                "State",
                                                style: xSmallSemiBold12Primary(
                                                  color: GlorifiColors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: GlorifiColors
                                                          .bermudaGray),
                                                  color: GlorifiColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: TypeAheadField(
                                                  noItemsFoundBuilder:
                                                      (context) {
                                                    return Container(
                                                      height: 0,
                                                    );
                                                  },
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                    controller:
                                                        _typeAheadController,
                                                    //autofocus: true,
                                                    style:
                                                        smallRegular16Primary()
                                                            .copyWith(
                                                                color:
                                                                    GlorifiColors
                                                                        .black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(15.h),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      hintText: "State",
                                                    ),
                                                  ),
                                                  suggestionsCallback:
                                                      (pattern) async {
                                                    List<ProductsAvailable>
                                                        availableStates =
                                                        controller
                                                            .mortgageStateData
                                                            .where(
                                                      (ProductsAvailable
                                                          option) {
                                                        return option.stateName
                                                            .toLowerCase()
                                                            .startsWith(pattern
                                                                .toLowerCase());
                                                      },
                                                    ).toList();

                                                    return pattern.length != 0
                                                        ? LinkedHashSet<
                                                                    String>.from(
                                                                availableStates
                                                                    .map((e) =>
                                                                        e.stateName))
                                                            .toList()
                                                        : [];
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    return ListTile(
                                                      title: Text(
                                                        suggestion.toString(),
                                                        style:
                                                            smallRegular16Primary(),
                                                      ),
                                                      onTap: () {
                                                        _typeAheadController
                                                                .text =
                                                            suggestion
                                                                .toString();
                                                        controller
                                                            .validSelectedState(
                                                                suggestion
                                                                    .toString());
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      },
                                                    );
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {},

                                                ),
                                              ),
                                              SizedBox(
                                                height: 32.h,
                                              ),
                                              PrimaryDarkButton(
                                                title: "Apply Now",
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 60,
                                                textColor: GlorifiColors
                                                    .midnightBlueColor,
                                                icon: SvgPicture.asset(
                                                  GlorifiAssets.rightArrow,
                                                  color: GlorifiColors
                                                      .primaryButtonIconColor,
                                                ),
                                                primaryColor:
                                                    GlorifiColors.white,
                                                onTap: () {
                                                  controller.validSelectedState(_typeAheadController.text);
                                                  controller.checkValidState(isFromCreditCard);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                },
                                              ),
                                              SizedBox(
                                                height: sizingInfo.isTablet
                                                    ? 100.h
                                                    : 38.h,
                                              ),
                                              Visibility(
                                                visible:
                                                    isFromCreditCard == null
                                                        ? true
                                                        : false,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.w,
                                                      horizontal: 8.w),
                                                  child: InkWell(
                                                    onTap: shareApp,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Applying with a Co-Applicant?",
                                                              style:
                                                                  smallBold16Primary(
                                                                color:
                                                                    GlorifiColors
                                                                        .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              "Invite them to be a GloriFi member.",
                                                              style:
                                                                  smallRegular16Primary(
                                                                color:
                                                                    GlorifiColors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SvgPicture.asset(
                                                            GlorifiAssets
                                                                .shareIcon),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: isFromCreditCard == null
                                                    ? 36.h
                                                    : 0,
                                              ),
                                              Visibility(
                                                visible:
                                                    isFromCreditCard == null
                                                        ? true
                                                        : false,
                                                child: Text(
                                                  "Animo Mortgage Company LLC  d/b/a GloriFi Mortgage // NMLS #2267438",
                                                  style: tinyRegular8Primary(
                                                    color: GlorifiColors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: sizingInfo.isTablet
                                                    ? 40.h
                                                    : 0.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      addPaddingWhenKeyboardAppears(),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Visibility(
                      visible: isFromCreditCard == null ? false : true,
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              child: SvgPicture.asset(GlorifiAssets.caret_2),
                            ),
                            onTap: Get.back,
                          ),
                          Text(
                            "Credit Card",
                            style: headlineRegular21Secondary(
                              color: GlorifiColors.blueMidnightBlue,
                            ),
                          ).paddingOnly(
                            left: 32.w,
                          ),
                        ],
                      ).paddingOnly(
                        left: 24.w,
                        top: 30.h,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget generateAutoComplete(MortgagePreApplyController controller) {
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 5.h, right: 50.w),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
                  title: Text(
                    option.toString(),
                    style: smallRegular16Primary(),
                  ),
                  onTap: () {
                    onSelected(option.toString());
                    controller.validSelectedState(option.toString());
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                );
              },
              itemCount: options.length,
            ),
          ),
        ),
      ),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        } else {
          List<ProductsAvailable> availableStates =
              controller.mortgageStateData.where(
            (ProductsAvailable option) {
              return option.stateName
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase());
            },
          ).toList();
          return LinkedHashSet<String>.from(
              availableStates.map((e) => e.stateName)).toList();
        }
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
      fieldViewBuilder: (context, controller_, focusNode, onEditingComplete) {
        return TextField(
          style: smallRegular16Primary(),
          onChanged: (option) {
            controller.validSelectedState(option);
          },
          controller: controller_,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15.h),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: "State",
          ),
        );
      },
    );
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
      title: 'Use this link to download the GloriFi app',
      text: 'Use this link to download the GloriFi app',
      linkUrl: 'https://glorifiapp.com/',
      chooserTitle: 'Use this link to download the GloriFi app',
    );
  }
}
