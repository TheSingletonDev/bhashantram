import 'package:get/instance_manager.dart';
import 'menu_screen_controller.dart';

class MenuScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MenuScreenController());
  }
}
