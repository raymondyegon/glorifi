import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/notification_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

import '../../../../font_style_global.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    controller.getNotification();
    return Scaffold(
      appBar: GlorifiAppBar(
        elevation: 0.0,
        title: "Notification",
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.notificationModels.value.messages.length,
          itemBuilder: (BuildContext ctxt, int index) {
            final notification =
                controller.notificationModels.value.messages[index];
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: InkWell(
                onTap: () {
                  controller.markNotificationAsRead(notification);
                  Get.bottomSheet(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: 550.h,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SvgPicture.asset(
                                      "assets/images/swiper.svg"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  notification.title!,
                                  style: headlineRegular21Secondary(
                                    color: GlorifiColors.darkBlue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                notification.title!,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isScrollControlled: true,
                      barrierColor: Colors.transparent,
                      isDismissible: true,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30))),
                      enableDrag: true,
                      backgroundColor: Colors.white);
                  // Get.to(() => _notificationDetail(notification));
                },
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  horizontalTitleGap: 1,
                  tileColor: Colors.white,
                  title: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.notificationModels.value.messages[index]
                                    .read ==
                                true
                            ? Flexible(
                                child: Text(
                                  controller.notificationModels.value
                                      .messages[index].title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: headlineRegular21Primary(
                                    color: GlorifiColors.midnightBlue,
                                  ),
                                ),
                              )
                            : Flexible(
                                child: Text(
                                  controller.notificationModels.value
                                      .messages[index].title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: headlineBold21Secondary(
                                    color: GlorifiColors.midnightBlue,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          controller.notificationModels.value.messages[index]
                              .subtitle,
                          style: captionSemiBold14Primary(
                            color: GlorifiColors.midnightBlue,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    controller.timeAgoForNotification(
                        controller.notificationModels.value.messages[index]),
                    style: captionBold14Primary(
                      color: GlorifiColors.midnightBlue,
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
