import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/total_accounts_opened_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';

import 'custom_container.dart';

class EnableToSeeDataWidget extends StatelessWidget {
  const EnableToSeeDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Totals Accounts Opened',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Want to see your Total Accounts Opened?',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16.h,
          ),
          GetBuilder<TotalAccountsOpenedController>(
            init: TotalAccountsOpenedController(),
            builder: (c) {
              return AppButton(
                onTap: () => c.navigateToTotalOpenedAccounts(),
                height: 48.h,
                label: 'Enable to see data',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
