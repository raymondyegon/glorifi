import 'package:flutter/material.dart';

class CreditScoreDetails extends StatelessWidget {
  CreditScoreDetails({Key? key, required this.scoreChange, required this.date})
      : super(key: key);

  final int scoreChange;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            '${scoreChange > 0 ? '+' : ''}${scoreChange.toString()}pts',
            style: TextStyle(
              height: 2,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: scoreChange > 0 ? Color(0xFF1AD35E) : Color(0xFFD31A1A),
            ),
          ),
          Text(
            'Since ${date}',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFA8B6CB),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 200,
            child: Text(
              '*VantageScore® 3.0 credit score using Equifax data.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFCFD8E6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
