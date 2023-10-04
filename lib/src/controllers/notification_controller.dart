import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/model/notification_models.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:timeago/timeago.dart' as timeago;


class NotificationController extends BaseController {
  Rx<NotificationData> notificationModels = NotificationData(messages: []).obs;

  int get unreadNotificationCount {
    return notificationModels.value.messages
        .where((element) => element.read == false)
        .length;
  }

  @override
  void onInit() async {
    getNotification();
    super.onInit();
  }

  Future<void> getNotification() async {
    final response = await DataHelperImpl.instance.apiHelper.getNotifications();

    response.fold(
      (error) {
        change(error, status: RxStatus.error());
        // Handle error
      },
          (success) {
        NotificationModels notificationModel = success;
        notificationModels.value = notificationModel.data;

        change(notificationModels, status: RxStatus.success());
      },
    );
  }


  void markNotificationAsRead(Messages? notification) {
    if (notification != null) {
      // notification.read = true;
      DataHelperImpl.instance.apiHelper.markNotificationAsRead(notification);
      change(notificationModels, status: RxStatus.success());
    }
  }

  void deleteNotification(Messages? notification) {
    //
  }

  String timeAgoForNotification(Messages notification) {
    // Convert timestamp to date
    final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(
        int.parse(notification.timestamp.toString()));
    return timeago.format(timeStamp, allowFromNow: true);
  }
}
