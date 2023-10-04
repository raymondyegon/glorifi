import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/model/explore_data_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class ExploreController extends BaseController {
  RxList<ExploreData> exploreData = RxList();

  late final exploreDataJson;
  final _dataHelper = DataHelperImpl.instance;

  @override
  void onInit() async {
    getExploreData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getExploreData() async {
    try {
      final data = await getData();
      exploreData.clear();
      exploreData.addAll(data);
      update();
    } catch (e) {
      Log.error(e.toString());
    }
  }

  Future<List<ExploreData>> getData() async {
    final response = await _dataHelper.apiHelper.getExploreData();
    return response.fold((l) {
      throw l.errorMessage;
    }, (r) {
      return r;
    });
  }
}
