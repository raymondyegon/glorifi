import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/sections/bottom/retirement_account_tile.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../retirement_model.dart';

class RetirementAccountsCard extends StatelessWidget {
  final String retirementAccountType;
  final List<RetirementAccount> accounts;

  RetirementAccountsCard(
      {Key? key, required this.retirementAccountType, required this.accounts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            retirementAccountType == 'employer_sponsored_accounts'
                ? 'Employer-Sponsored Retirement'
                : 'Individual Retirement Accounts',
            style: TextStyle(
              color: GlorifiColors.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          children: [
            ...accounts.map((account) {
              return RetirementAccountTile(
                accountName: account.name,
                balance: account.balance,
                institution: account.institution,
                mask: account.mask,
              );
            }),
          ],
          initiallyExpanded: true,
        ),
      ),
    );
  }
}
