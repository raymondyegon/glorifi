import 'package:get/get.dart';
import 'package:glorifi/src/controllers/video_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class VideoPlayerBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<VideoController>(() => VideoController());
  }
}
