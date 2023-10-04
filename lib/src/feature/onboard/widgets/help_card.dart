import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCard extends StatelessWidget {
  final String title;
  final String text;
  const HelpCard({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(title),
          Text(text),
          ElevatedButton(
              // ignore: unnecessary_lambdas
              onPressed: () => Get.back(),
              child: const Text('Got It'))
        ],
      ),
    );
  }
}
