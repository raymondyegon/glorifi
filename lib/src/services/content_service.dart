import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

class ContentService extends GetxService {
  ContentService();

  final _dataHelper = DataHelperImpl.instance;

  Future<dynamic> viewedContent(String contentId) async {
    final response =
        await _dataHelper.apiHelper.viewedContent(contentId: contentId);
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
