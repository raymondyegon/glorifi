import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/feature/errors/widget/error_500_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/widgets/plaid_linked_accounts_widget/account_tile.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/controller/manage_accounts_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class PlaidLinkedAccountsWidget extends StatelessWidget {
  const PlaidLinkedAccountsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ManageAccountsController controller =
        Get.put(ManageAccountsController());

    return StatefulWrapper(
      onInit: () {
        controller.loadData();
      },
      child: controller.obx(
        (state) {
          return SingleChildScrollView(
            // padding: EdgeInsets.symmetric(
            //   horizontal: 24.w,
            //   vertical: 32.h,
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: Text(
                    'Unlink Accounts.',
                    style: leadRegular24Secondary(
                        color: GlorifiColors.cornflowerBlue),
                  ),
                ),
                ...controller.institutions
                    .map(
                      (institution) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            institution.institutionName,
                            style: captionBold14Primary(
                              color: GlorifiColors.cornflowerBlue,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            margin: EdgeInsets.only(bottom: 32.h),
                            decoration: BoxDecoration(
                              color: GlorifiColors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(0, 10),
                              //     color: Colors.black.withOpacity(0.1),
                              //     blurRadius: 55,
                              //   ),
                              // ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Column(children: [
                                ...institution.accounts
                                    .map(
                                      (account) => AccountTile(
                                          title: account.officialName ?? '',
                                          subtitle:
                                              '${account.name} | *${account.mask}',
                                          onTap: null),
                                    )
                                    .toList(),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    onTap: () {
                                      controller.unlinkInstitution(institution);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.h,
                                        horizontal: 24.w,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            GlorifiAssets.unlink,
                                            color: GlorifiColors.lightRed,
                                          ),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                            child: Text(
                                              'Unlink Account${institution.accounts.length > 1 ? 's' : ''}',
                                              style: bodyBold18Primary(
                                                color: GlorifiColors
                                                    .cornflowerBlue,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList()
              ],
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
            style: leadRegular24Secondary(color: GlorifiColors.cornflowerBlue),
          ),
        ),
      ),
    );
  }
}
