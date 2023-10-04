// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

class CreditScoreGauge extends StatelessWidget {
  int score;
  var currScore = 300.obs;
  Timer? timer;

  CreditScoreGauge(this.score, {Key? key}) : super(key: key);

  void start() {
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (currScore >= score) {
        timer.cancel();
        return;
      }
      currScore += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    start();
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          // Gauge
          // Container(
          //   margin: EdgeInsets.all(10),
          //   // color: Colors.red,
          //   child: SfRadialGauge(
          //     axes: <RadialAxis>[
          //       RadialAxis(
          //         showLabels: false,
          //         showTicks: false,
          //         minimum: 300,
          //         maximum: 850,
          //         startAngle: 160,
          //         endAngle: 20,
          //         axisLineStyle: AxisLineStyle(
          //           thickness: 0.15,
          //           cornerStyle: CornerStyle.bothCurve,
          //           thicknessUnit: GaugeSizeUnit.factor,
          //           color: Color(0xFF1A3365),
          //         ),
          //         pointers: <GaugePointer>[
          //           RangePointer(
          //             enableAnimation: true,
          //             value: currScore.toDouble(),
          //             width: 0.15,
          //             sizeUnit: GaugeSizeUnit.factor,
          //             gradient: SweepGradient(
          //               colors: <Color>[Color(0xFF29519F), Color(0xFFB7C9EC)],
          //               stops: <double>[0.25, 0.75],
          //             ),
          //             cornerStyle: CornerStyle.bothCurve,
          //             // width: 25,
          //           ),
          //           MarkerPointer(
          //             enableAnimation: true,
          //             value: currScore.toDouble() - 12,
          //             markerHeight: 25,
          //             markerWidth: 25,
          //             markerType: MarkerType.circle,
          //             enableDragging: true,
          //             color: Color.fromARGB(0, 9, 142, 203),
          //             borderWidth: 4,
          //             borderColor: Color.fromARGB(255, 255, 255, 255),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),

          // Credit Score Center
          Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Credit Score',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFCFD8E6),
                  ),
                ),
                Text(
                  currScore.toString(),
                  style: TextStyle(
                    fontFamily: 'UniversWide',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // minimum label
          Positioned(
            left: 30,
            bottom: 105,
            child: Text(
              '300',
              style: TextStyle(
                fontFamily: 'Univers',
                fontSize: 23.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFCFD8E6),
              ),
            ),
          ),

          // maximum label
          Positioned(
            right: 30,
            bottom: 105,
            child: Text(
              '850',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFCFD8E6),
              ),
            ),
          )
        ],
      ),
    );
  }
}
