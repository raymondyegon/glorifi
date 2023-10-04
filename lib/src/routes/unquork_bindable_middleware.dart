import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../services/session_manager_service.dart';

class UnquorkBindableMiddleware extends GetMiddleware {
  final _sessionManagerService = Get.find<SessionManagerService>();
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {}
}
