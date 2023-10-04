import 'package:flutter/material.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';

class LocalAuthDemo extends StatefulWidget {
  LocalAuthDemo({Key? key}) : super(key: key);

  @override
  LocalAuthDemoState createState() => LocalAuthDemoState();
}

class LocalAuthDemoState extends State<LocalAuthDemo> {
  bool _localAuthFlag = false;
  @override
  void initState() {
    // Todo: implement initState
    super.initState();
    init();
  }

  init() async {
    _localAuthFlag = await LocalAuth.authenticateWithBiometrics();
    setState(() {
      _localAuthFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Auth Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("LocalBioAuth Status: "),
            _localAuthFlag
                ? Text("Authernticated by Biometrics")
                : Text(
                    "Not Authernticated or Biometrics hasn't setup on your device"),
          ],
        ),
      ),
    );
  }
}
