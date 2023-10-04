import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/controller/manage_accounts_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/widgets/institution_dropdown.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class ManagePersonalSnapshotScreen extends GetView<ManageAccountsController> {
  const ManagePersonalSnapshotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ManageAccountsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Accounts",
          style: headlineRegular20Primary(color: GlorifiColors.almostBlack)
              .copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF4F5F7),
        iconTheme: IconThemeData(
          color: Color(0xFF171A20),
        ),
        elevation: 0,
      ),
      body: controller.obx(
        (state) => Container(
          width: double.infinity,
          color: Color(0xFFF4F5F7),
          child: ListOfLinkedAccounts(context),
        ),
        onLoading: Center(
          child: GlorifiSpinner(),
        ),
        onEmpty: Center(
          child: Text("No Linked Accounts Found"),
        ),
        onError: (error) => Center(
          child: Text("Error fetching Linked Accounts"),
        ),
      ),
    );
  }

  Widget ListOfLinkedAccounts(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 10, left: 20, right: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Linked Accounts",
              style: headlineRegular20Primary(color: GlorifiColors.almostBlack)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Column(
          children: [
            ...controller.institutions.map(
              (institution) => InstitutionDropdown(
                institution: institution.institutionName,
                dropdownItems: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: institution.accounts.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {}, // TODO: implement on Tap
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 14.0, bottom: 14.0, right: 16),
                          child: Row(
                            children: [
                              institution.institutionName == "Chase"
                                  ? SvgPicture.asset(
                                      GlorifiAssets.chaseLogo,
                                      color: Color(0xFF126BC5),
                                    )
                                  // TODO: Show image from String or Online
                                  : Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Colors.grey),
                                      child: Icon(
                                        Icons.account_balance_sharp,
                                        size: 20,
                                      )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${institution.accounts[index].name}",
                                    style: captionSemiBold14Primary(
                                        color: GlorifiColors.almostBlack),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "••••${institution.accounts[index].mask}",
                                    style: xSmallSemiBold12Primary(
                                        color: GlorifiColors.textDarkBlue),
                                  ),
                                ],
                              ).paddingOnly(left: 11),
                              // Text("${institution.accounts[index].balance}"),
                              Spacer(),
                              Text(
                                r"$6,427.00",
                                style: captionBold14Primary(
                                    color: GlorifiColors.blueIcon),
                              ), // TODO: Hardcoded as no data from Api
                              Icon(Icons.chevron_right).paddingOnly(left: 14),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      var alert = CupertinoAlertDialog(
                        title: Center(child: Text("Unlink Accounts")),
                        content: Text(
                            "Are you sure you want to remove these accounts? You can add them again later."),
                        actions: [
                          TextButton(onPressed: Get.back, child: Text("No")),
                          TextButton(
                              onPressed: () async {
                                Get.back();
                                await controller.unlinkAccount(
                                    institution: institution);
                              },
                              child: Text("Yes, Unlink")),
                        ],
                      );
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return alert;
                          });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            GlorifiAssets.unlink,
                            color: GlorifiColors.blueIcon,
                          ),
                          SizedBox(width: 7.83),
                          Text(
                            "Unlink Institution",
                            style: captionBold14Primary(
                                color: GlorifiColors.blueIcon),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 20),
        Divider(
          thickness: 1,
          color: Color(0xFFD4DEF4),
        ),
        LinkNewAccountButton().paddingSymmetric(horizontal: 20, vertical: 20),
      ],
    );
  }
}
