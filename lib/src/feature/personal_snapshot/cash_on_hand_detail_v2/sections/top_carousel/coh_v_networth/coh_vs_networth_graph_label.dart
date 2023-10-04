import 'package:flutter/material.dart';

class CohVsNetworthGraphLabel extends StatelessWidget {
  const CohVsNetworthGraphLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFFC2D1F0),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Cash on Hand',
                style: TextStyle(
                    color: Color(0xFFC2D1F0), fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFF6490E7),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Net Worth',
                style: TextStyle(
                    color: Color(0xFFC2D1F0), fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
