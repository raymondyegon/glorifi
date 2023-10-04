import 'package:flutter/src/widgets/scroll_controller.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/structure/base_controller.dart';

import '../../../utils/sliding_panel.dart';

enum CockpitTab {
  today,
  snapshot,
  accounts,
  products,
  rewards,
}

class CockpitController extends BaseController {
  PanelController panelController = PanelController();
  late RxBool isDraggable = true.obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  Rx<CockpitTab> currentTab = Rx<CockpitTab>(CockpitTab.today);

  @override
  void onInit() {
    super.onInit();
  }

  void onTabSelected(CockpitTab screen) {
    currentTab.value = screen;
    update();
  }

  bool isTabSelected(CockpitTab screen) {
    return currentTab.value == screen;
  }

  void setIsDraggable(bool isScrolled) {
    isDraggable.value = isScrolled;
    // change isDraggable value after some time
  }

  setVerticalScrollController(ScrollController scroll) {
    scrollController.value = scroll;
    return scroll;
  }
}
