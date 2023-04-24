import 'package:get/instance_manager.dart';

import 'text_screen_api.dart';
import 'text_screen_controller.dart';

class TextNMTScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TextScreenAPICalls());
    Get.put(TextScreenController());
  }
}
