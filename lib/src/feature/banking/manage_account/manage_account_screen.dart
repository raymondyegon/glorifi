import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/widgets/plaid_linked_accounts_widget/plaid_linked_accounts_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({Key? key}) : super(key: key);

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Manage',
      ),
      backgroundColor: GlorifiColors.productsBgWhite,
      body: PlaidLinkedAccountsWidget(),
    );
  }
}
