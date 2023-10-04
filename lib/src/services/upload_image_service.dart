import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

class UploadImageService extends GetxService {
  late String guid;
  late String token;

  UploadImageService();

  final _dataHelper = DataHelperImpl.instance;

  Future<String?> uploadImage(
      {required String imagePath,
      required String profileCompletionPercentage}) async {
    String fileName = imagePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath, filename: fileName),
      "percentage": profileCompletionPercentage
    });
    final response = await _dataHelper.apiHelper.uploadImage(formData);
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
      },
      (r) {
        return r;
      },
    );
  }
}
