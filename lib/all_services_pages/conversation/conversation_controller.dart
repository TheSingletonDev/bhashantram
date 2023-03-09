import 'package:bhashantram/all_services_pages/conversation/conversation_screen_api.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../global/global_app_constants.dart';
import 'conversation_constants.dart';

class ConversationController extends GetxController {
  late final ConversationScreenAPICalls _conversationScreenAPICalls;
  late final PersonOneUIController _personOneUIController;
  @override
  void onInit() {
    super.onInit();
    _conversationScreenAPICalls = Get.find();
    _personOneUIController = Get.find();
  }

  Map<String, dynamic> _ulcaConfig = {};
  Map<String, dynamic> get ulcaConfig => _ulcaConfig;

  final List<String> _avaiablePersonOneLanguagesBottom = [];
  List<String> get avaiablePersonOneLanguagesBottom => _avaiablePersonOneLanguagesBottom;

  bool _isULCAConfigLoaded = false;
  bool get isULCAConfigLoaded => _isULCAConfigLoaded;
  void changeIsULCAConfigLoaded({required bool isULCAConfigLoaded}) {
    _isULCAConfigLoaded = isULCAConfigLoaded;
    update();
  }

  void fetchULCAConfig() {
    Map<String, dynamic> payloadToSend = GlobalAppConstants.deepCopyMap(ulcaConfigRequestPayload);

    payloadToSend['pipelineTasks'] = [taskTypeASR, taskTypeNMT, taskTypeTTS];
    payloadToSend['pipelineRequestConfig']['submitter'] = submitterToUse;

    _conversationScreenAPICalls.sendULCAConfigRequest(url: 'url', payload: payloadToSend).then((response) {
      _ulcaConfig = GlobalAppConstants.deepCopyMap(tempULCAConfigResponse);
      changeIsULCAConfigLoaded(isULCAConfigLoaded: true);
      _avaiablePersonOneLanguagesBottom.clear();
      List<dynamic> languagesParameterInULCAConfig = _ulcaConfig['languages'];
      for (Map<String, dynamic> eachLanguageDict in languagesParameterInULCAConfig) {
        _avaiablePersonOneLanguagesBottom.add(eachLanguageDict['sourceLanguage'].toString());
      }
      if (_avaiablePersonOneLanguagesBottom.isNotEmpty) {
        _personOneUIController.changeAreLangsAvaiableForPersonOne(areLangsAvaiableForPersonOne: false);
      }
    });
  }
}
