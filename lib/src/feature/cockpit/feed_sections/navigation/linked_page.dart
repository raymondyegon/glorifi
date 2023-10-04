import 'package:flutter/material.dart';

class LinkedPage extends StatelessWidget {
  const LinkedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Linked Page'),
      ),
    );
  }
}
