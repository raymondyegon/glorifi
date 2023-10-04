// Package imports:
import 'package:get/get.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    registerDataSources();
  }

  registerDataSources() {}
}
