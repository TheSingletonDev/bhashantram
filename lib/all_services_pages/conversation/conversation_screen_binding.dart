import 'package:get/instance_manager.dart';

import 'conversation_controller.dart';
import 'conversation_screen_api.dart';
import 'widgets/widget_person_one_feature_set_bottom/per1_recorder_controller.dart';
import 'widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'widgets/widget_person_two_feature_set_top/per2_ui_controller.dart';

class ConversationScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ConversationScreenAPICalls());
    Get.put(PersonTwoUIController());
    Get.put(PersonOneUIController());
    Get.put(ConversationController());
    Get.put(PersonOneRecorderController());
  }
}
