import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/bronze_card.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_header.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_navigation.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_status.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 4, 33, 56),
            Color.fromARGB(255, 20, 45, 69),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfileHeader(),
                if (controller.profileCompleted) BronzeCard(),
                if (!controller.profileCompleted) ProfileStatus(),
                ProfileNavigation(),
              ],
            ),
          )),
    );
  }
}
