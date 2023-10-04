import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:intl/intl.dart';

class RetirementAccountTile extends StatelessWidget {
  final String accountName;
  final String institution;
  final String mask;
  final double balance;

  RetirementAccountTile({
    Key? key,
    required this.accountName,
    required this.institution,
    required this.mask,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    accountName,
                    style: TextStyle(
                      color: GlorifiColors.darkBlueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  '${institution} ${mask}',
                  style: TextStyle(
                    color: GlorifiColors.textColor,
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              '\$${NumberFormat.decimalPattern('en_us').format(balance)}',
              style: TextStyle(
                color: GlorifiColors.darkBlueColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color.fromARGB(255, 225, 221, 221)),
        ),
      ),
    );
  }
}
