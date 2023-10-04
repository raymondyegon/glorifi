import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/MenuUiModel.dart';
import 'menu_item_collapsed.dart';
import 'menu_item_expanded.dart';

class CreditCardMenu extends StatelessWidget {
  final MenuUiModel data;

  const CreditCardMenu({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => data.isExpanded.value
        ? MenuItemExpanded(data: data)
        : MenuItemCollapsed(data: data));
  }
}
