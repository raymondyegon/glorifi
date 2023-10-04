// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:glorifi/src/controllers/menu_navigation_controller.dart';
import 'package:get/get.dart';

class MobileNavbar extends StatelessWidget {
  const MobileNavbar({
    Key? key,
    required this.selectedScreenIndex,
    required this.listItems,
    required this.selectScreen(int arg),
  }) : super(key: key);

  final int selectedScreenIndex;
  final List<Map<String, Object>> listItems;
  final Function selectScreen;

  @override
  Widget build(BuildContext context) {
    final _openNavController = Get.put(MenuNavigationController());
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      iconSize: 40,
      onTap: (index) => selectScreen(index),
      currentIndex: selectedScreenIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.flight),
          label: listItems[selectedScreenIndex]['title'] as String,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_balance),
          label: listItems[selectedScreenIndex]['title'] as String,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.badge),
          label: listItems[selectedScreenIndex]['title'] as String,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.house),
          label: listItems[selectedScreenIndex]['title'] as String,
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            iconSize: 40,
            icon: const Icon(Icons.menu),
            onPressed: _openNavController.toggleDrawer,
          ),
          label: listItems[selectedScreenIndex]['title'] as String,
        ),
      ],
    );
  }
}
