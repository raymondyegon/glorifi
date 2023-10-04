import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/edit_profile_appbar.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';

class LoginCredentials extends StatefulWidget {
  LoginCredentials({Key? key}) : super(key: key);

  @override
  _LoginCredentials createState() => _LoginCredentials();
}

class _LoginCredentials extends State<LoginCredentials> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        editProfileAppbar(() {
          Navigator.pop(context);
        }, "Login Credentials"),
        Expanded(
          child: Container(
              color: editProfileBackgroundColor,
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        editProfileSmallText("login info"),
                        Row(
                          children: [],
                        )
                      ],
                    ).paddingAll(20),
                  ).paddingOnly(top: 10),
                ],
              ))),
        )
      ],
    )));
  }
}
