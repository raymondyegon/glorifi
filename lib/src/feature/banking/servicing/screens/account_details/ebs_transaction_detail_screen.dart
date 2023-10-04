import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_transaction.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

class EBSTransactionDetailScreen extends StatelessWidget {
  const EBSTransactionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EBSContainer(
        screenBackground: GlorifiColors.white,
        title: 'Transaction Details',
        children: _content());
  }

  List<Widget> _content() {
    final EBSTransaction transaction = Get.arguments;

    return [
      SizedBox(height: 64),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          width: double.infinity,
          child: Text(
            transaction.merchant,
            style: headlineSemiBold20Primary(color: GlorifiColors.greyProfile),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          width: double.infinity,
          child: Text(
            transaction.amount.formatCurrencyWithZero(),
            style: headlineRegular40Secondary(
              color: GlorifiColors.ebonyBlue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      if (transaction.isPending)
        Text(
          "Pending",
          style: bodyRegular18Primary(),
        ),
      SizedBox(
        height: 61,
      ),
      _singleItem('Transaction Date', transaction.transactionDate.toMMMdyyyy()),
      if (transaction.postedDate != null)
        _singleItem('Posted Date', transaction.postedDate!.toMMMdyyyy()),
      _singleItem(
          'Transaction Time', transactionTime(transaction.transactionDate)),
      _singleItem('Transaction Type', transaction.type),
      _singleItem(
        'Category',
        transaction.description,
        hasBorder: false,
      ),
    ];
  }

  String transactionTime(DateTime date) {
    DateTime _cst = dateTimeToZone(zone: "CST", datetime: date);
    return '${DateFormat.Hm().format(_cst)} CST';
  }

  Widget _singleItem(String text1, String text2, {bool hasBorder = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.only(bottom: 13, top: 15, left: 16, right: 16),
      decoration: BoxDecoration(
        border: hasBorder
            ? Border(
                bottom: BorderSide(
                  color: GlorifiColors.altoGrey,
                ),
              )
            : null,
      ),
      child: Row(children: [
        Text(
          text1,
          maxLines: 1,
          style: xSmallRegular12Primary(
            color: GlorifiColors.greyProfile,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: Text(
            text2,
            style: xSmallSemiBold12Primary(
              color: GlorifiColors.greyProfile,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ]),
    );
  }
}
