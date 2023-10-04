import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarousalIndicator extends GetView {
  var dotsCount = 0.obs;
  var position = 0.obs;

  CarousalIndicator({Key? key, required int dotsCount, required int position})
      : super(key: key) {
    this.dotsCount.value = dotsCount;
    this.position.value = position;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DotsIndicator(
        key: GlobalKey(),
        dotsCount: dotsCount.value,
        position: position.value.toDouble(),
        decorator: DotsDecorator(
          spacing: EdgeInsets.only(left: 2, right: 2),
          activeSize: const Size(25.0, 8.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.grey,
          activeColor: Color(0xFF1A336F),
        ),
      ),
    );
  }
}
