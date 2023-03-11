import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:bhashantram/global/global_app_constants.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../conversation_constants.dart';
import '../../conversation_screen_socket.dart';
import '../widget_person_two_feature_set_top/per2_ui_controller.dart';

class PersonOneSocketRecorderController extends GetxController {
  late SocketConnectService _socketConnect;
  int silenceSize = 40;

  @override
  void onInit() {
    super.onInit();
    _socketConnect = Get.find();
  }

  void recordVoice() {
    Permission.microphone.request().then((permission) {
      if (permission.isGranted) {
        Map<dynamic, dynamic> asrToSend = GlobalAppConstants.deepCopyMap(socketTaskSeq[0]);
        Map<dynamic, dynamic> translationToSend = GlobalAppConstants.deepCopyMap(socketTaskSeq[1]);
        Map<dynamic, dynamic> ttsToSend = GlobalAppConstants.deepCopyMap(socketTaskSeq[2]);
        asrToSend['config']['language']['sourceLanguage'] = Get.find<PersonOneUIController>().currentSelectedLanguageCode;
        translationToSend['config']['language']['sourceLanguage'] = Get.find<PersonOneUIController>().currentSelectedLanguageCode;
        translationToSend['config']['language']['targetLanguage'] = Get.find<PersonTwoUIController>().currentSelectedLanguageCode;
        ttsToSend['config']['language']['sourceLanguage'] = Get.find<PersonTwoUIController>().currentSelectedLanguageCode;
        ttsToSend['config']['gender'] = Get.find<PersonOneUIController>().isFemaleBtnSelected ? 'female' : 'male';

        List<Map<dynamic, dynamic>> socketTaskSeqToSend = [asrToSend, translationToSend, ttsToSend];
        // var socketTaskSeqToSend = socketTaskSeq.map((eachMap) => GlobalAppConstants.deepCopyMap(eachMap)).toList();
        _socketConnect.recordVoice(socketTaskSeqToSend: socketTaskSeqToSend, isReqForPerOneAtBottom: true);
      } else {}
    });
  }

  void stopRecording() {
    _socketConnect.stopRecording();
  }
}
