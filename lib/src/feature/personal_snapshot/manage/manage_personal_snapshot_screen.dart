import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/personal_snapshot/link_data_flow/link_data_flow_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/widgets/plaid_linked_accounts_widget/plaid_linked_accounts_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';



class ManagePersonalSnapshotScreen extends GetView {
  const ManagePersonalSnapshotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget adaptiveScaffold(Widget gridItem, var sizingInfo) {
      return AdaptiveScaffoldWeb().getScaffold(
        context: context,
        backgroundColor: GlorifiColors.productsBgWhite,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageHeader(
                  showTrailingButton: false,
                  headerTitle: "Manage",
                  horizontalPadding: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.5.w),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.5.w,
                  vertical: 0.h,
                ),
                child: gridItem,
              )
            ],
          ),
        ),
      );
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isDesktop) {
        return adaptiveScaffold(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                  maxWidth: 672.w,
                ),
                child: ManagePersonalTabs(
                  tabs: [
                    Tab(
                      text: 'Add',
                    ),
                    Tab(
                      text: 'Remove',
                    ),
                  ],
                  children: [
                    FinancialData(sizingInfo: sizingInfo),
                    PlaidLinkedAccountsWidget(),
                  ],
                ),
              )
            ],
          ),
          sizingInfo,
        );
      } else if (sizingInfo.isTablet || sizingInfo.isWebMobile) {
        return adaptiveScaffold(
            Container(
              constraints: BoxConstraints(
                maxWidth: 672.w,
              ),

              child: ManagePersonalTabs(
                tabs: [
                  Tab(
                    text: 'Add',
                  ),
                  Tab(
                    text: 'Remove',
                  ),
                ],
                children: [
                  FinancialData(sizingInfo: sizingInfo),
                  PlaidLinkedAccountsWidget(),
                ],
              ),
            ),
            sizingInfo);
      } else {
        return AdaptiveScaffoldNative().getScaffold(
          context: context,
          backgroundColor: GlorifiColors.bgBoxColor,
          glorifiAppBar: GlorifiAppBar(
            title: 'Manage',
            textStyle: bodySemiBold18Primary(
              color: GlorifiColors.midnightBlue,
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ManagePersonalTabs(
              tabs: [
                Tab(
                  text: 'Add',
                ),
                Tab(
                  text: 'Remove',
                ),
              ],
              children: [
                FinancialData(sizingInfo: sizingInfo),
                PlaidLinkedAccountsWidget(),
              ],
            ).paddingOnly(top: 28.h),
          ),
        );
      }
    });
  }
}

class ManagePersonalTabs extends StatefulWidget {
  const ManagePersonalTabs({
    Key? key,
    required this.children,
    required this.tabs,
  }) : super(key: key);

  final List<Widget> children;
  final List<Widget> tabs;

  @override
  _ManagePersonalTabsState createState() => _ManagePersonalTabsState();
}

class _ManagePersonalTabsState extends State<ManagePersonalTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Material(
      color: GlorifiColors.productsBgWhite,
      child: ListView(
        shrinkWrap: true,
        children: [
          //SizedBox(height: 32.h),
          Container(
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  left: 0.0,
                  bottom: 0,
                  child: Container(
                    width: deviceWidth,
                    height: 5,
                    decoration: BoxDecoration(color: GlorifiColors.silver),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: GlorifiColors.darkGrey80,
                  labelColor: GlorifiColors.darkBlue,
                  tabs: widget.tabs,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: smallBold16Secondary(),
                  unselectedLabelStyle: smallRegular16Secondary(),
                  indicatorWeight: 5,
                  indicatorColor: GlorifiColors.darkBlue,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.maxFinite,
            height: deviceHeight / 1.4,
            child: TabBarView(
              controller: _tabController,
              children: widget.children,
            ),
          )
        ],
      ),
    );
  }
}
