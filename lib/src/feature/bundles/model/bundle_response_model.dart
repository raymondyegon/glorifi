import 'package:glorifi/src/feature/bundles/model/bundle_model.dart';

class BundleResponseModel {
  List<BundleModel>? bundleList;

  BundleResponseModel({
    this.bundleList,
  });

  BundleResponseModel.fromJson(dynamic json) {
    final bundleHomeFront = json['data']['bundles'][0]['homefront'];
    final bundleProtect = json['data']['bundles'][0]['protect'];
    final bundleHeroes = json['data']['bundles'][0]['heros'];
    bundleList = [];

    bundleList?.add(
      BundleModel(
        name: "Homefront",
        total: bundleHomeFront['total'],
        completed: bundleHomeFront['completed'],
      ),
    );
    bundleList?.add(
      BundleModel(
        name: "Protect",
        total: bundleProtect['total'],
        completed: bundleProtect['completed'],
      ),
    );
    bundleList?.add(
      BundleModel(
        name: "Heroes",
        total: bundleHeroes['total'],
        completed: bundleHeroes['completed'],
      ),
    );
  }
}
