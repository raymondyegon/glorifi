import 'package:get/get.dart';
import 'package:glorifi/src/feature/text_widget_demo/text_filed_widget_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class TextFiledWidgetBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<TextFiledWidgetController>(() => TextFiledWidgetController());
  }
}
