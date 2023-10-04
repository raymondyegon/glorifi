import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/total_accounts_opened_controller.dart';

import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';
import 'package:glorifi/src/widgets/shared/app_drop_down.dart';

import '../../../widgets/appbars/glorifi_appbar.dart';
import 'widgets/account_duration_location_widget.dart';
import 'widgets/accounts_count_status_widget.dart';
import 'widgets/open_close_status_widget.dart';

class TotalAccountsOpenedScreen extends StatelessWidget {
  const TotalAccountsOpenedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: 'Total Accounts Opened',
        trailing: Trailing(
          text: "Edit",
          onTap: () {},
        ),
      ),
      body: Container(
        color: Colors.black26.withOpacity(0.1),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: GetBuilder<TotalAccountsOpenedController>(
          init: TotalAccountsOpenedController(),
          builder: (controller) {
            if (controller.status == RxStatus.loading()) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountsCountStatusWidget(
                  accountCount: '${controller.data.count}',
                  fontWeight: FontWeight.bold,
                  status: controller.data.accountStatus,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AccountDurationAndLocationWidget(
                  duration: controller.data.duration!,
                  location: controller.data.location!,
                ),
                SizedBox(
                  height: 48.h,
                ),
                OpenCloseStatusWidget(
                  fullState: controller.data.fullState,
                  closedAccountCount: (controller.data.fullState!)
                      ? controller.data.closedAccountCount
                      : 0,
                  openAccountCount: (controller.data.fullState!)
                      ? controller.data.openAccountCount
                      : 0,
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  controller.data.description!,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: 16.h,
                ),
                !controller.data.fullState!
                    ? AppButton(
                        onTap: () {},
                        height: 48.h,
                        label: 'Enable my data',
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(
                          8.sp,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Open Accounts',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          AppDropDownList(
                            height: 56,
                            value: controller.openAccount,
                            items: controller.data.openAccounts!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  '$value Accounts',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              );
                            }).toList(),
                            onChanged: (String value) =>
                                controller.setOpenAccountValue(value),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            'Closed Accounts',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          AppDropDownList(
                            height: 56,
                            value: controller.closedAccount,
                            items: controller.data.closedAccounts!.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  '$value Accounts',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              );
                            }).toList(),
                            onChanged: (String value) =>
                                controller.setClosedAccountValue(value),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black87,
                                ),
                                borderRadius: BorderRadius.circular(
                                  8.sp,
                                ),
                                color: Colors.black87),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 48.h,
                            ),
                            child: Text(
                              'Open Glorify Checking Account\nBanner Add',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
