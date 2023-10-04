import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';


class FourBankingTasksGrid extends StatelessWidget {
  const FourBankingTasksGrid({
    Key? key, this.width = 342, this.height = 88
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Column(children: [
            _buildBorderedRect(const EdgeInsets.fromLTRB(0, 0, 5, 5), "Transfer", 'assets/icons/switch_horizontal.svg', width: width/2, height: height/2),
            _buildBorderedRect(const EdgeInsets.fromLTRB(0, 5, 5, 0), "Find ATM", 'assets/icons/cash_banknote.svg', width: width/2, height: height/2),
          ],),
          Column(children: [
            _buildBorderedRect(const EdgeInsets.fromLTRB(5, 0, 0, 5), "Deposit Checks", 'assets/icons/camera.svg', width: width/2, height: height/2),
            _buildBorderedRect(const EdgeInsets.fromLTRB(5, 5, 0, 0), "ManageAccount", 'assets/icons/pencil.svg', width: width/2, height: height/2),
          ],),
        ],),
      ),
    );
  }

  Container _buildBorderedRect(EdgeInsets padding, String text, String iconName, {double width = 44, double height = 171}) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
          ),
          child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset(
              iconName,
            width: 24,
            // color: GlorifiColors.textColor,
          ),
              SizedBox(width: 10,),
              Text(text),
            ],
          ))
      ),
    );
  }
}