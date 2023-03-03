import 'package:bhashantram/all_services_pages/conversation/conversation_screen_controller.dart';
import 'package:get/instance_manager.dart';

class ConversationScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ConversationScreenController());
  }
}
