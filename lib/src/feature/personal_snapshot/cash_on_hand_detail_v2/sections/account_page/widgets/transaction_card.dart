import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/account_details_page_controller.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // logo for the transaction
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Color.fromARGB(255, 214, 213, 211),
                  ),
                ),
              ),

              SizedBox(width: 15),

              // transaction name and date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    //TODO: fix name
                    transaction.name.length > 15
                        ? transaction.name.substring(0, 15)
                        : transaction.name,
                    // 'Uber Trip',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  // date
                  Text(
                    DateFormat.MMMd().format(transaction.date),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // right side
          Column(
            children: [
              Text(
                transaction.amount.formatCurrencyWithZero(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                transaction.pending ? 'Pending' : '',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF444E60),
                ),
              ),
            ],
          )

          // date and pending state
        ],
      ),
    );
  }
}
