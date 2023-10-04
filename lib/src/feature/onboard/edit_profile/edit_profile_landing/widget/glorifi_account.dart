import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/edit_profile_appbar.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_card.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';

class GlorifiAccount extends StatefulWidget {
  GlorifiAccount({Key? key}) : super(key: key);

  @override
  _GlorifiAccount createState() => _GlorifiAccount();
}

class _GlorifiAccount extends State<GlorifiAccount> {
  // List<dynamic> cardsData = [
  //   {
  //     "title": "BANKING DETAILS",
  //     "body": "You’ve completed your banking information"
  //   },
  //   {
  //     "title": "MEMBERSHIP",
  //     "body": "Sign up for products to complete your profile"
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        editProfileAppbar(() {
          Navigator.pop(context);
        }, "Glorifi Account"),
        Expanded(
          child: Container(
              color: editProfileBackgroundColor,
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: screenSize.width - 80,
                          child: LinearProgressIndicator(
                            value: 0.2,
                            color: profileRed,
                            backgroundColor: editProfileCardBackgroundColor,
                          )),
                      Icon(
                        Icons.star_outline,
                        color: profileRed,
                        size: 18,
                      ),
                    ],
                  ),
                  profileCard(
                      true,
                      context,
                      "PERSONAL INFO",
                      "You've completed your personal details information",
                      Icon(
                        Icons.check_circle_outline,
                        color: profileIconColor,
                      )).paddingOnly(top: 10),
                  profileCard(
                      true,
                      context,
                      "MAILING ADDRESS",
                      "You've completed your mailing address information",
                      Icon(
                        Icons.check_circle_outline,
                        color: profileIconColor,
                      )),
                  profileCard(
                      true,
                      context,
                      "BANKING DETAILS",
                      "You've completed your banking information",
                      Icon(
                        Icons.check_circle_outline,
                        color: profileIconColor,
                      )),
                  profileCard(
                      false,
                      context,
                      "MEMBERSHIP",
                      "You haven't signed up for any Glorifi products. Sign up to complete your profile",
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      )),
                ],
              ))),
        )
      ],
    )));
  }
}
