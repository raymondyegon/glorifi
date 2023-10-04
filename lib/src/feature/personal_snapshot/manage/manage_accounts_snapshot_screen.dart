import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/feature/errors/widget/error_500_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/controller/manage_accounts_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/linked_institutions_model.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class ManageAccountsSnapshotScreen extends StatelessWidget {
  const ManageAccountsSnapshotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManageAccountsController controller =
        Get.put(ManageAccountsController());

    PlaidController plaidController = Get.put(PlaidController());

    final String title = 'Manage Accounts';
    final String subTitle = 'Linked Accounts';

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          appBar: GlorifiAppBar(
            title: title,
          ),
          backgroundColor: GlorifiColors.productsBgWhite,
          body: StatefulWrapper(
            onInit: () {
              controller.loadData();
            },
            child: controller.obx(
              (state) {
                return SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(24.sp),
                      width: sizingInfo.isDesktop ? 1024.w : double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 64.h),
                          Text(
                            title,
                            style: headlineBold26Secondary(
                              color: GlorifiColors.almostBlack,
                            ),
                          ),
                          SizedBox(height: 61.h),
                          Text(
                            subTitle,
                            style: headlineSemiBold20Primary(
                              color: GlorifiColors.almostBlack,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 24.h),
                          ...controller.institutions
                              .map(
                                (institution) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 32.h),
                                      decoration: BoxDecoration(
                                        color: GlorifiColors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: ExpansionItems(
                                          dropdownItems: makeDropdownItems(
                                            institution.accounts,
                                          ),
                                          name: institution.institutionName,
                                          controller: controller,
                                          institution: institution,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          Divider(),
                          SizedBox(
                            height: 20.h,
                          ),
                          LinkNewAccountButton(
                            onTap: () async {
                              await plaidController.openPlaid();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              onLoading: Center(
                child: GlorifiSpinner(),
              ),
              onError: (_) {
                return Center(
                  child: Error500Widget(onTap: () {
                    controller.loadData(showLoading: true);
                  }),
                );
              },
              onEmpty: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Text(
                  'You Have No Linked Accounts.',
                  style: leadRegular24Secondary(
                      color: GlorifiColors.cornflowerBlue),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Widget> makeDropdownItems(List<LinkedAccountModel> accounts) {
  return [
    ...accounts.map(
      (account) {
        final image =
            account.img != null ? Image.network(account.img!) : SizedBox();
        return InkWell(
          onTap: null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 24.h,
              horizontal: 4.w,
            ),
            decoration: BoxDecoration(
              color: GlorifiColors.white,
              border: Border(
                bottom: BorderSide(
                  color: GlorifiColors.greyD8,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: image,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account.officialName ?? '',
                              style: captionSemiBold14Primary(
                                color: GlorifiColors.blueMidnightBlue,
                              ),
                            ),
                            Text(
                              '••••${account.mask}',
                              style: xSmallSemiBold12Primary(
                                color: GlorifiColors.blueMidnightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 14.r),
                      child: Text(
                        '\$${account.value != null ? account.value : 0}',
                        style: captionBold14Primary(
                          color: GlorifiColors.blueMidnightBlue,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: GlorifiColors.bluesDarkGray,
                      size: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  ];
}

class ExpansionItems extends StatefulWidget {
  final List<Widget> dropdownItems;
  final String name;
  final ManageAccountsController controller;
  final LinkedInstitutionModel institution;

  ExpansionItems({
    Key? key,
    required this.name,
    required this.dropdownItems,
    required this.controller,
    required this.institution,
  }) : super(key: key);

  @override
  State<ExpansionItems> createState() => _ExpansionItemsState();
}

class _ExpansionItemsState extends State<ExpansionItems> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        '${widget.dropdownItems.length} ${widget.name}',
        style: bodyBold18Primary(
          color: GlorifiColors.almostBlack,
        ),
      ),
      children: [
        ...widget.dropdownItems,
        UnlinkAccount(
          controller: widget.controller,
          institution: widget.institution,
        ),
      ],
      childrenPadding: EdgeInsets.symmetric(horizontal: 10),
      initiallyExpanded: false,
      trailing: Icon(
        _expanded ? Icons.remove : Icons.add,
        color: GlorifiColors.bluesDarkGray,
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _expanded = expanded;
        });
      },
    );
  }
}

class UnlinkAccount extends StatelessWidget {
  const UnlinkAccount({
    Key? key,
    required this.controller,
    required this.institution,
  }) : super(key: key);

  final ManageAccountsController controller;
  final LinkedInstitutionModel institution;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.unlinkInstitution(institution);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              GlorifiAssets.unlink,
              color: GlorifiColors.cornflowerBlue,
            ),
            SizedBox(width: 8.w),
            Text(
              'Unlink Account${institution.accounts.length > 1 ? 's' : ''}',
              style: bodyBold18Primary(
                color: GlorifiColors.cornflowerBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
