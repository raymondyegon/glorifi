import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_transaction.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class EBSTransactionsList extends StatefulWidget {
  final bool showHeader;
  final EBSTransactions transactions;
  final Function? onLoadMore;
  final bool loadingMoreTransactions;

  const EBSTransactionsList({
    required this.showHeader,
    required this.transactions,
    this.onLoadMore,
    this.loadingMoreTransactions = false,
    Key? key,
  }) : super(key: key);

  @override
  State<EBSTransactionsList> createState() => _EBSTransactionsListState();
}

class _EBSTransactionsListState extends State<EBSTransactionsList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.onLoadMore != null) {
      _scrollController.addListener(() {
        if (_scrollController.position.maxScrollExtent - 152 <= _scrollController.position.pixels &&
            widget.loadingMoreTransactions == true) {
          widget.onLoadMore!();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
          BoxShadow(
            color: GlorifiColors.black.withOpacity(0.05),
            blurRadius: 16,
          )
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: Container(
            color: GlorifiColors.white,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                if (widget.showHeader) _header(),
                if (widget.transactions.items.isNotEmpty) ...showTransactions(),
                if (widget.loadingMoreTransactions == true &&
                    widget.transactions.items.length < widget.transactions.total)
                  loadingItem(),
                if (widget.transactions.items.isEmpty) noTransactions()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingItem() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 60,
            child: ShimmeryPlaceHolder(
              radius: 4,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 60,
            child: ShimmeryPlaceHolder(
              radius: 4,
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Transactions",
              style: customGlorifiStyle(
                  weight: FontWeight.bold, size: 16, color: GlorifiColors.midnightBlueColor),
            ),
            Ripple(
              onTap: () => Get.toNamed(Routes.allTransactions),
              child: Text("View All",
                  style: customGlorifiStyle(
                      weight: FontWeight.bold, size: 12, color: GlorifiColors.lightBlue)),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> showTransactions() {
    DateTime? _lastDateTime;
    return [
      ...widget.transactions.items
          .asMap()
          .map((i, transaction) {
            bool _showDate = false;
            bool _showBorder = false;
            if (_lastDateTime == null ||
                _lastDateTime != DateUtils.dateOnly(transaction.transactionDate)) {
              _showDate = true;
              _lastDateTime = DateUtils.dateOnly(transaction.transactionDate);
            }

            if (i < widget.transactions.items.length - 1 &&
                DateUtils.dateOnly(transaction.transactionDate) !=
                    DateUtils.dateOnly(widget.transactions.items[i + 1].transactionDate)) {
              _showBorder = true;
            }
            return MapEntry(
                i, singleTransaction(transaction, showDate: _showDate, showBorder: _showBorder));
          })
          .values
          .toList()
    ];
  }

  Widget singleTransaction(
    EBSTransaction transaction, {
    bool showDate = false,
    bool showBorder = false,
  }) {
    
    final color = transaction.transactionPosn == "credit"
        ? GlorifiColors.greenAmount
        : GlorifiColors.cornflowerBlue;
    return SliverToBoxAdapter(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.ebsTransactionDetail, arguments: transaction);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDescription(showDate, transaction.transactionDate,
                        transaction.merchant, transaction.description),
                    _buildAmount(
                        transaction.amount, color, transaction.isPending),
                  ],
                ),
                SizedBox(height: 16),
                if (showBorder)
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: GlorifiColors.altoGrey,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTransactions() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Text('No Recent Transactions',
              style: customGlorifiStyle(
                weight: FontWeight.w400,
                size: 14,
                color: GlorifiColors.darkGrey80,
              )),
        ),
      ),
    );
  }

  Widget _buildDescription(
      bool showDate, DateTime? date, String merchant, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDate)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              date!.toMMMdyyyy(),
              style: xSmallBold12Primary(
                color: GlorifiColors.greyProfile,
              ),
            ),
          ),
        Text(
          merchant,
          style: captionBold14Primary(color: GlorifiColors.cornflowerBlue),
        ),
        Text(
          description,
          style: xSmallSemiBold12Primary(color: GlorifiColors.dateDarkGrey),
        ),
      ],
    );
  }

  Widget _buildAmount(double amount, Color color, bool pending) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amount.formatCurrencyWithZero(),
          style: smallBold16Primary(
            color: color,
          ),
        ),
        if (pending)
          Text(
            "Pending",
            style: xSmallRegular12Primary(
              color: GlorifiColors.silver,
            ),
          ),
      ],
    );
  }
}
