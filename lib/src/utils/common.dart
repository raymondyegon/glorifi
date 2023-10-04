import 'package:glorifi/src/core/logger.dart';

class Common {
  static Map filterGraph(Map data) {
    Map filterMap = Map();
    Map sunMap = Map();
    try {
      data.forEach((key, value) {
        if (!sunMap.containsKey((key as DateTime).month)) {
          sunMap[key.month] = value;
          filterMap[key] = value;
        }
      });
    } catch (e) {
      Log.error(e.toString());
    }
    return filterMap;
  }
}
