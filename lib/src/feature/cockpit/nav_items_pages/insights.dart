import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class InsightsPage extends StatelessWidget {
  InsightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Card(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Entered amount is : $amount",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        margin: const EdgeInsets.all(10),
      )),
    );
  }
}
