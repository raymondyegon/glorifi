import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/item_profile_navigation.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/share_app_button.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

import 'navigation_data.dart';

class ProfileNavigation extends StatelessWidget {
  const ProfileNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120.h,
            child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: _getDelegate(),
                itemCount: navigationItems.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ItemProfileNavigation(
                    title: navigationItems[index]['title'],
                    iconPath: navigationItems[index]['icon'],
                    onTap: () => Get.toNamed(navigationItems[index]["link"]),
                  );
                }),
          ),
          const SizedBox(height: 8),
          ShareAppButton(onTap: () => showSnackBar('WIP: Implement later'))
        ],
      ),
    );
  }

  _getDelegate() => SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 2,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 8);
}
