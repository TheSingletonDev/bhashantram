import 'package:get/instance_manager.dart';

import 'text_screen_controller.dart';

class TextNMTScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TextNMTScreenAPICalls());
  }
}
