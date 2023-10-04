import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/SnapshotBalance.dart';

class NetworthTotal extends StatelessWidget {
  final double total;

  NetworthTotal(this.total, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Savings Across All Linked Accounts",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SnapshotBalance(balance: total, fontSize: 45),
        ],
      ),
    );
  }
}
