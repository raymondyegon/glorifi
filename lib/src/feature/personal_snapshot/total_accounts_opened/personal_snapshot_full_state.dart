import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/total_accounts_opened_controller.dart';

import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import 'widgets/account_duration_location_widget.dart';
import 'widgets/accounts_count_status_widget.dart';
import 'widgets/custom_container.dart';
import 'widgets/open_close_status_widget.dart';

class PersonalSnapshotsFullState extends StatelessWidget {
  const PersonalSnapshotsFullState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: 'Personal Snapshot',
        trailing: Trailing(
          text: "Edit",
          onTap: () {},
        ),
      ),
      body: PersonalSnapshotFullStateBody(),
    );
  }
}

class PersonalSnapshotFullStateBody
    extends GetView<TotalAccountsOpenedController> {
  const PersonalSnapshotFullStateBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: GetBuilder<TotalAccountsOpenedController>(
        init: TotalAccountsOpenedController(),
        builder: (controller) => InkWell(
          onTap: () => controller.navigateToEnableToSeeDataScreen(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Totals Accounts Opened',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  IconButton(
                    onPressed: () => controller.navigateToTotalOpenedAccounts(),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              AccountsCountStatusWidget(
                accountCount: '${controller.data.count}',
                status: controller.data.accountStatus,
              ),
              SizedBox(
                height: 8.h,
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
                closedAccountCount: controller.data.closedAccountCount,
                openAccountCount: controller.data.openAccountCount,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                controller.data.description!,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
