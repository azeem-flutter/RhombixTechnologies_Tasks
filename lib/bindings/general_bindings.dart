import 'package:campuspulse/features/notification/controller/notification_controller.dart';
import 'package:campuspulse/services/user_repository.dart';
import 'package:campuspulse/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(UserRepository(), permanent: true);
    // Get.put(NotificationController(), permanent: true);
  }
}
