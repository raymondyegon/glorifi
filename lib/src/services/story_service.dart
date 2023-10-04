import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/stories_prefab.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';

class StoryService extends GetxService {
  StoryService();

  final _dataHelper = DataHelperImpl.instance;

  Future<dynamic> getNextStory(int x, int storiesPerPage) async {
    List _stopFeed() {
      return [StoryModel(type: StoryType.ServerError), StoryPrefabs.LastStory];
    }

    List _generateErrorStories() {
      return List.generate(storiesPerPage,
          (int index) => StoryModel(type: StoryType.ServerError));
    }

    final response = await _dataHelper.apiHelper
        .getNextStory(x: x, storiesPerPage: storiesPerPage);
    return response.fold((l) {
      if (x == 0) {
        return _stopFeed();
      } else {
        return _generateErrorStories();
      }
    }, (r) async {
      if (x == 0) {
        if (r[0].type == StoryType.ServerError) {
          return _stopFeed();
        }
        if (await _dataHelper.cacheHelper.showGlorifiStory()) {
          r[0] = StoryPrefabs.GlorifiStory;
          _dataHelper.cacheHelper.updateShowGlorifiStory(false);
        }
      }
      return r;
    });
  }
}
