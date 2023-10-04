import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CreditCardDetailView extends StatelessWidget {
  const CreditCardDetailView({
    Key? key,
    required this.progress,
    required this.cardType,
    required this.lastFourCardNumber,
    required this.amount,
    required this.availableAmount,
    required this.paymentDueDate,
    required this.minimumAmountDue,
  }) : super(key: key);

  final double progress;
  final String cardType;
  final int lastFourCardNumber;
  final String amount;
  final String availableAmount;
  final String paymentDueDate;
  final String minimumAmountDue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
          color: GlorifiColors.greyBgColor,
          border: Border.all(
            color: GlorifiColors.greyBgColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardType,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
              Text(
                "Visa ***" + lastFourCardNumber.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              String.fromCharCodes(Runes('\u0024')) + amount,
              style: TextStyle(
                fontSize: 37.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans",
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last Statement Balance",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "OpenSans",
                  color: Colors.black,
                ),
              ),
              Text(
                "Available: " +
                    String.fromCharCodes(Runes('\u0024')) +
                    availableAmount,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "OpenSans",
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width,
            height: 5.h,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: progress,
                valueColor:
                    AlwaysStoppedAnimation<Color>(GlorifiColors.bloodOrange),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment due " + paymentDueDate,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "univers",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Minimum payment due " +
                        String.fromCharCodes(Runes('\u0024')) +
                        minimumAmountDue,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      fontFamily: "OpenSans",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "OpenSans",
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          GlorifiColors.cornflowerBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ))))
            ],
          ),
          SizedBox(
            height: 25.h,
          ),
          Divider(
            height: 1.h,
            color: Colors.black,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "View Transactions & More",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "univers",
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
