import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AccountsCountStatusWidget extends StatelessWidget {
  final String accountCount;
  final String? status;
  final FontWeight? fontWeight;

  const AccountsCountStatusWidget(
      {Key? key, required this.accountCount, this.status = '', this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
            accountCount,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: fontWeight,
                ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            child: VerticalDivider(
              color: Colors.black,
              thickness: 2,
            ),
          ),
          Text(
            status!,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
