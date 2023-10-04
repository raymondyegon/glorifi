import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/callback_controller.dart';
import 'package:glorifi/src/controllers/support/contact_support_controller.dart';
import 'package:glorifi/src/controllers/support/email_support_controller.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/controllers/support/guest_user_controller.dart';

import '../controllers/profile_controller.dart';
import '../controllers/support/faq_search_controller.dart';

class FAQCategoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQCategoriesController>(
      () => FAQCategoriesController(),
      fenix: true,
    );

    Get.lazyPut<EmailSupportController>(
      () => EmailSupportController(),
      fenix: true,
    );

    Get.lazyPut<FaqSearchController>(
      () => FaqSearchController(),
      fenix: true,
    );

    Get.lazyPut<ContactSupportController>(
      () => ContactSupportController(),
      fenix: true,
    );
    Get.lazyPut<CallBackController>(
      () => CallBackController(),
      fenix: true,
    );
    Get.lazyPut<GuestUserController>(
      () => GuestUserController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
  }
}
