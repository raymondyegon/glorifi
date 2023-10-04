import 'package:glorifi/src/feature/bundles/model/bundle_model.dart';

class BundleDetailsResponseModels {
  String? title;
  int? points;
  List<BundleTask>? tasks;

  BundleDetailsResponseModels({
    this.title,
    this.points,
    this.tasks,
  });

  BundleDetailsResponseModels.fromJson(dynamic json) {
    title = json['data']['title'];
    points = json['data']['points'];
    if (json['data']['steps'] != null) {
      tasks = [];
      json['data']['steps'].forEach((v) {
        tasks?.add(BundleTask(
          title: v['title'],
          complete: v['completed'],
          route: v['route'],
        ));
      });
    }
  }
}
