import 'package:get/get.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class DemoImagePickerBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ImagePickerController>(() => ImagePickerController(),
        fenix: true);
  }
}
