import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/person_one_controller.dart';
import 'package:get/instance_manager.dart';

import 'widgets/widget_person_two_feature_set_top/person_two_controller.dart';

class ConversationScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(PersonOneController());
    Get.put(PersonTwoController());
  }
}
