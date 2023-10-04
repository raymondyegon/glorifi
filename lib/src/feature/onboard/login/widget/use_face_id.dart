import 'package:flutter/material.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/model/biometric_config.dart';
import 'package:glorifi/src/feature/onboard/widgets/underline_text.dart';
import 'package:local_auth/local_auth.dart';

class UseFaceIdWidget extends StatefulWidget {
  final Function()? onTap;

  const UseFaceIdWidget({Key? key, this.onTap}) : super(key: key);

  @override
  State<UseFaceIdWidget> createState() => _UseFaceIdWidgetState();
}

class _UseFaceIdWidgetState extends State<UseFaceIdWidget> {
  BiometricType? _bioType;
  BiometricConfig? _biometricConfig;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    var _temp = await LocalAuth.getAvailableBiometrics();
    setState(() {
      _bioType = _temp;
      _biometricConfig = BiometricConfig(_bioType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnderlineText(
      onTap: widget.onTap,
      text: _biometricConfig?.buttonTitle ?? "",
      textSize: 16,
    );
  }
}
