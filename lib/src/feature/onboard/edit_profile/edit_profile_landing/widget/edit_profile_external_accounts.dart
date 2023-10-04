import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/add_external_account.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/external_account_empty_state.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/external_account_list.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/widgets/plaid_linked_accounts_widget/plaid_linked_accounts_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../../../../model/profile_model.dart';

class EditProfileExternalAccounts extends StatelessWidget {
  final ProfileController profileController = Get.find();
  final EditProfileController editProfileController = Get.find();
  final Function() onTap;
  final AdaptiveSizingInfo? sizingInfo;

  List<ExternalAccount> get externalAccountList =>
      profileController.userProfile.externalAccounts.toList();

  EditProfileExternalAccounts({
    Key? key,
    required this.onTap,
    this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TextConstants.linkedExternalAccounts,
              style: smallBold16Primary(color: GlorifiColors.midnightBlue),
            ),
            _getIcon(),
          ],
        ),
        SizedBox(height: 10.h),
        Obx(
          () => profileController.hasExternalAccountLinked
              ? Container(
                  child: ExternalAccountList(
                    externalAccountList: externalAccountList,
                    onTapUnlink: _onTapUnlink,
                  ).marginOnly(bottom: 6.h),
                )
              : ExternalAccountEmptyState(onTap: onTap),
        ),
        Obx(() => profileController.hasExternalAccountLinked
            ? AddExternalAccount(onTap: onTapAddExternalAccountButton)
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _getIcon() {
    return Obx(
      () => Icon(
        profileController.hasExternalAccountLinked
            ? Icons.check_circle_outline_outlined
            : Icons.error_outline,
        size: 20,
        color: profileController.hasExternalAccountLinked
            ? GlorifiColors.lightGreenProfile
            : GlorifiColors.redError,
      ),
    );
  }

  void _onTapUnlink(ExternalAccount account) {
    // TODO: This isn't ideal. But crunching and shipping
    Get.to(_unlinkAccountContainer);
  }

  void onTapAddExternalAccountButton() {
    editProfileController.gotoLinkedAccounts();
  }

  Widget _unlinkAccountContainer() {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: "Unlink Accounts",
      ),
      body: PlaidLinkedAccountsWidget(),
    );
  }
}
