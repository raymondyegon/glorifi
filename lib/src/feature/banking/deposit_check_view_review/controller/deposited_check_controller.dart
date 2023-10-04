import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:glorifi/src/feature/banking/deposit_check_view_review/data/deposited_checks.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/model/check_model.dart';

import 'package:glorifi/src/structure/base_controller.dart';

enum CheckStatus {
  Rejected,
  Complete,
}

class DepositedCheckController extends BaseController {
  var currentPage = 0.obs;
  var isSelected = false.obs;
  var menuItems = ['Recent', 'Checking', 'Savings'];
  final PageController pageController = PageController();
  final List<CheckModel> _items = checkModel.obs;

  List<CheckModel> get items {
    return _items;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
