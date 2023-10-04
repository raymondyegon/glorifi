import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/widgets/content_tile.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:intl/intl.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateless widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  StatefulWrapper({
    Key? key,
    required this.onInit,
    required this.child,
  }) : super(key: key);

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class PersonalSnapshot extends StatelessWidget {
  const PersonalSnapshot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.put(SnapshotController());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: StatefulWrapper(
        onInit: () {
          snapshotController.loadData(
              showLoading: !snapshotController.didLoad.value);
        },
        child: AdaptiveBuilder(builder: (context, sizingInfo) {
          return Column(
            children: [
              SizedBox(height: 40.h),
              _chart(snapshotController.tappedButtonIndex.value),
              SizedBox(height: 10.h),
              Container(
                padding: sizingInfo.isDesktop || sizingInfo.isTablet
                    ? null
                    : EdgeInsets.fromLTRB(24.w, 0, 24.w, 0.h),
                margin: sizingInfo.isDesktop || sizingInfo.isTablet
                    ? null
                    : const EdgeInsets.only(bottom: 60),
                child: Obx(
                  () {
                    return Column(
                      children: [
                        _SnapshotTile(
                          title: "Total Net Worth",
                          assetPath: GlorifiAssets.reportMoney,
                          value: snapshotController.currentNetWorth,
                          onTap: () => snapshotController.toNetWorth(0),
                          isEnabled:
                              FeatureFlagManager.snapshotTotalNetWorthEnabled,
                          isLoading: snapshotController
                              .netWorthController.loading.isTrue,
                          isFocused:
                              snapshotController.tappedButtonIndex.value == 0,
                        ),
                        _SnapshotTile(
                          title: "Cash on Hand",
                          assetPath: GlorifiAssets.cash_banknote,
                          value: snapshotController.currentCashOnHand,
                          onTap: () => snapshotController.toCashOnHand(1),
                          isEnabled:
                              FeatureFlagManager.snapshotCashOnHandEnabled,
                          isLoading: snapshotController
                              .cashOnHandController.loading.isTrue,
                          isFocused:
                              snapshotController.tappedButtonIndex.value == 1,
                        ),
                        _SnapshotTile(
                          title: "Retirement",
                          assetPath: GlorifiAssets.chartBar,
                          value: snapshotController.currentRetirement,
                          onTap: () =>
                              snapshotController.toRetirementSavings(2),
                          isLoading: snapshotController
                              .retirementController.loading.isTrue,
                          isFocused:
                              snapshotController.tappedButtonIndex.value == 2,
                        ),
                        _SnapshotTile(
                          title: "Credit Score",
                          assetPath: GlorifiAssets.medal,
                          isDollar: false,
                          onTap: () => snapshotController.toCreditScore(3),
                          isEnabled:
                              FeatureFlagManager.snapshotCreditScoreEnabled,
                          value: snapshotController.currentCreditScore,
                          isFocused:
                              snapshotController.tappedButtonIndex.value == 3,
                        ),
                        _SnapshotTile(
                          title: TextConstants.totalDebt,
                          assetPath: GlorifiAssets.chartPie2,
                          value: snapshotController.currentDebt,
                          onTap: () => snapshotController.toTotalDebt(4),
                          isEnabled: FeatureFlagManager.snapshotDebtEnabled,
                          isLoading:
                              snapshotController.debtController.loading.isTrue,
                          isFocused:
                              snapshotController.tappedButtonIndex.value == 4,
                        ),
                        //Home Value Removed for Now
                        // _SnapshotTile(
                        //   title: "Home Value",
                        //   assetPath: GlorifiAssets.home2,
                        //   value: snapshotController.currentHomeValue,
                        //   onTap: () => snapshotController.toHomeValue(5),
                        //   isEnabled:
                        //       FeatureFlagManager.snapshotHomeValueEnabled,
                        //   isLoading: snapshotController
                        //       .homeValueController.loading.isTrue,
                        //   isFocused:
                        //       snapshotController.tappedButtonIndex.value == 5,
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  //TODO show chart according to last visited thing
  Widget _chart(int? index) {
    return Container();
    // switch (index) {
    //   case 1:
    //     return Text(
    //       'TODO cash on hand chart',
    //       style: TextStyle(),
    //     );
    //   case 2:
    //     return Text(
    //       'TODO retirement chart',
    //       style: TextStyle(),
    //     );
    //   case 3:
    //     return Text(
    //       'TODO credit score chart',
    //       style: TextStyle(),
    //     );
    //   case 4:
    //     return Text(
    //       'TODO total debt chart',
    //       style: TextStyle(),
    //     );
    //   case 5:
    //     return Text(
    //       'TODO home value chart',
    //       style: TextStyle(),
    //     );
    //   default:
    //     return Container();
    //}
  }
}

class _SnapshotTile extends StatefulWidget {
  const _SnapshotTile({
    Key? key,
    required this.title,
    required this.assetPath,
    required this.value,
    required this.onTap,
    this.isEnabled = true,
    this.isDollar = true,
    this.isLoading = false,
    this.isFocused = false,
  }) : super(key: key);

  final String title;
  final String assetPath;
  final int value;
  final Function()? onTap;
  final bool isEnabled;
  final bool isDollar;
  final bool isLoading;
  final bool isFocused;

  @override
  State<_SnapshotTile> createState() => _SnapshotTileState();
}

class _SnapshotTileState extends State<_SnapshotTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isEnabled == false) {
      return _disabled();
    }
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          onTap: loading || widget.isLoading
              ? () {}
              : () async {
                  try {
                    loading = true;
                    setState(() {});
                    await widget.onTap!();
                  } finally {
                    loading = false;
                    setState(() {});
                  }
                },
          child: Container(
            decoration: BoxDecoration(
                color: widget.isFocused
                    ? GlorifiColors.lightBlueBg
                    : GlorifiColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: widget.isFocused
                      ? GlorifiColors.borderLightBlue
                      : Colors.transparent,
                )),
            padding: EdgeInsets.only(
              left: 10,
              right: 14,
            ),
            height: 60,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: widget.isFocused
                          ? GlorifiColors.white
                          : GlorifiColors.greyIconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        widget.assetPath,
                        color: widget.isFocused
                            ? GlorifiColors.blueFocusedItem
                            : GlorifiColors.greyInactiveIcon,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: captionBold14Primary(
                      color: widget.isFocused
                          ? GlorifiColors.blueFocusedItem
                          : GlorifiColors.almostBlack,
                    ),
                  ),
                ),
                widget.isLoading || loading
                    ? Container(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : widget.title == TextConstants.totalDebt
                        ? Text(
                            widget.isDollar
                                ? "${widget.value != 0 ? '-' : ''}${widget.isDollar ? r'$' : ''}${NumberFormat.decimalPattern().format(widget.value.abs()).toString()}"
                                : widget.value == 0
                                    ? 'Check'
                                    : '\$${NumberFormat.decimalPattern().format(widget.value.abs()).toString()}',
                            style: smallBold16Primary(
                              color: widget.isFocused
                                  ? GlorifiColors.blueFocusedItem
                                  : GlorifiColors.almostBlack,
                            ),
                          )
                        : Text(
                            widget.isDollar
                                ? "${widget.value < 0 ? '-' : ''}${widget.isDollar ? r'$' : ''}${NumberFormat.decimalPattern().format(widget.value.abs()).toString()}"
                                : widget.value == 0
                                    ? 'Check'
                                    : '\$${NumberFormat.decimalPattern().format(widget.value.abs()).toString()}',
                            style: smallBold16Primary(
                              color: widget.isFocused
                                  ? GlorifiColors.blueFocusedItem
                                  : GlorifiColors.almostBlack,
                            ),
                          ),
                if (!widget.isLoading && !loading)
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: SvgPicture.asset(
                      GlorifiAssets.caretRightSmall,
                      color: GlorifiColors.darkBlueTint[500],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _disabled() {
    return ContentTile(
      asset: widget.assetPath,
      title: widget.title,
      showArrow: false,
      onTap: () {},
      backgroundColor: Colors.grey.shade400,
    );
  }
}
