import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class NewsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  var address = "".obs;
  late TabController tabController;
  var _dataHelper = DataHelperImpl.instance;
  List<String> categories = [
    "All",
    "Tech",
    "Finance",
    "Politics",
    "Sports",
    "Spirituality",
    "Lifestyle",
    "Travel"
  ];

  @override
  void onInit() async {
    tabController = TabController(length: categories.length, vsync: this);
    final response = await _dataHelper.apiHelper.getNewsFeedApi();
    response.fold(
      (l) => change(l, status: RxStatus.error()),
      (r) => change(r, status: RxStatus.success()),
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
