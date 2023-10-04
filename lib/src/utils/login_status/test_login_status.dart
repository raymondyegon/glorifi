import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';

import '../../routes/app_pages.dart';

class TestLoginStatus extends StatefulWidget {
  TestLoginStatus({Key? key}) : super(key: key);

  @override
  State<TestLoginStatus> createState() => TestLoginStatusState();
}

class TestLoginStatusState extends State<TestLoginStatus> {
  alreadyLoggedIn() {
    Get.defaultDialog(title: "TEST", middleText: "Already logged in");
  }

  notLoggedIn() {
    Get.toNamed(Routes.createProfilePlus, arguments: "REDIRECT");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter button at the bottom example'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {
              CheckLoginStatus.checkLoginStatus(alreadyLoggedIn, notLoggedIn);
            },
            child: Text("CHECK LOGIN STATUS"),
          ),
        ),
      ),
    );
  }
}
