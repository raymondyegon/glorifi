import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/item_external_account.dart';
import 'package:glorifi/src/model/profile_model.dart';

class ExternalAccountList extends StatelessWidget {
  final List<ExternalAccount> externalAccountList;
  final Function(ExternalAccount account) onTapUnlink;

  const ExternalAccountList({
    required this.externalAccountList,
    required this.onTapUnlink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: externalAccountList.length,
      itemBuilder: (context, index) {
        var model = externalAccountList[index];

        return ItemExternalAccount(
          account: model,
          onTapUnlink: onTapUnlink,
          isLastItem: index == externalAccountList.length - 1,
        );
      },
    );
  }
}
