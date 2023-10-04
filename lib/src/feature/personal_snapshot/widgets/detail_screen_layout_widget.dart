import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/amount_with_description.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/internal_server_error_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/no_found.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/pull_stamp_note.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../../font_style_global.dart';

class DetailScreenLayoutWidget extends StatelessWidget {
  const DetailScreenLayoutWidget({
    Key? key,
    this.headerText = '',
    this.mainValue,
    this.mainValueDescription = '',
    required this.chart,
    this.title = '',
    required this.lastPullInfo,
    required this.dataSourceLabel,
    this.isLoading = false,
    this.bottomContent = const [],
    this.isNoFound = false,
    this.refresh = null,
    this.statusApi = '',
  }) : super(key: key);

  final String? title;
  final String? headerText;
  final double? mainValue;
  final String? mainValueDescription;
  final Widget chart;
  final String lastPullInfo;
  final String dataSourceLabel;
  final bool isLoading;
  final List<Widget> bottomContent;
  final bool isNoFound;
  final GestureTapCallback? refresh;
  final String statusApi;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInformation) {
      final sizingInfo = sizingInformation;

      var content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText ?? '',
                style: smallRegular16Primary(
                  color: GlorifiColors.midnightBlueColor,
                ),
              ),
              SizedBox(height: 24.h),
              if (mainValue != null)
                AmountWithDescription(
                  amount: mainValue!,
                  description: mainValueDescription,
                ),
              if (mainValue == null && isNoFound) NoFound(),
              chart,
              PullStampNote(title: lastPullInfo, subtitle: dataSourceLabel),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            children: bottomContent,
          ),
        ],
      );

      var show = null;

      switch (statusApi.length > 0 ? statusApi[0] : '') {
        case '5':
          show = InternalServerErrorWidget(onTap: refresh);
          break;
        default:
          show = sizingInfo.isNativeMobile
              ? content
              : Row(
                  children: [
                    Flexible(flex: 1, fit: FlexFit.tight, child: content),
                    sizingInfo.isDesktop ? Spacer(flex: 1) : SizedBox()
                  ],
                );
          break;
      }

      return isLoading
          ? Center(child: GlorifiSpinner())
          : ContainerInfo(
              sizingInfo: sizingInfo, container: show, title: title!);
    });
  }
}

class ContainerInfo extends StatelessWidget {
  const ContainerInfo(
      {Key? key,
      required this.sizingInfo,
      required this.container,
      required this.title})
      : super(key: key);

  final Widget container;
  final AdaptiveSizingInfo sizingInfo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: sizingInfo.isDesktop
            ? 200.w
            : sizingInfo.isTablet
                ? 34.5.w
                : 24.w,
        vertical: 32.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sizingInfo.isWebMobile ||
              sizingInfo.isTablet ||
              sizingInfo.isDesktop)
            PageHeader(
              headerTitle: title,
              showWebPageFont: true,
              showTrailingButton: false,
              horizontalPadding: 0,
            ),
          if (sizingInfo.isWebMobile ||
              sizingInfo.isTablet ||
              sizingInfo.isDesktop)
            SizedBox(height: 48.h),
          container,
        ],
      ),
    );
  }
}
