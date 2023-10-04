import 'package:flutter/cupertino.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/environment/environment.dart';

class GlobalAppStateNotifier extends ChangeNotifier {
  bool _isPlaidSandbox = false;

  bool get isPlaidSandbox => _isPlaidSandbox;

  String get plaidLinkToken => _isPlaidSandbox
      ? '${ApiEndPoints.plaidLinkToken}?plaidEnv=sandbox'
      : ApiEndPoints.plaidLinkToken;

  GlobalAppStateNotifier() {
    init();
  }

  init() {
    if (Environment().config is! ProdConfig) {
      DataHelperImpl.instance.cacheHelper
          .isPlaidSandboxEnvironment()
          .then((value) {
        _isPlaidSandbox = value;
      });
    }
  }

  void togglePlaidSandbox() {
    _isPlaidSandbox = !_isPlaidSandbox;
    DataHelperImpl.instance.cacheHelper
        .savePlaidSandboxEnvironment(_isPlaidSandbox);
    notifyListeners();
  }
}
