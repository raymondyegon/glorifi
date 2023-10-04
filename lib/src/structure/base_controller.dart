// Flutter imports:
import 'package:flutter/material.dart';
import 'package:glorifi/src/structure/core_controller.dart';

class BaseController extends CoreController {
  void openDrawer(GlobalKey<ScaffoldState> key) {
    if (!key.currentState!.isEndDrawerOpen) {
      key.currentState!.openEndDrawer();
    } else {
      key.currentState!.openDrawer();
    }
  }

  void closeDrawer(GlobalKey<ScaffoldState> key) {
    key.currentState!.openDrawer();
  }
}
