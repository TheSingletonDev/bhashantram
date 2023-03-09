import 'dart:convert';

import 'package:bhashantram/all_services_pages/conversation/conversation_screen_api.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:bhashantram/global/enum_global.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../global/global_app_constants.dart';
import 'conversation_constants.dart';
import 'widgets/widget_person_two_feature_set_top/per2_ui_controller.dart';

class ConversationController extends GetxController {
  late final ConversationScreenAPICalls _conversationScreenAPICalls;
  late final PersonOneUIController _personOneUIController;
  late final PersonTwoUIController _personTwoUIController;
  @override
  void onInit() {
    super.onInit();
    _conversationScreenAPICalls = Get.find();
    _personOneUIController = Get.find();
    _personTwoUIController = Get.find();
  }

  Map<dynamic, dynamic> _ulcaConfig = {};
  Map<dynamic, dynamic> get ulcaConfig => _ulcaConfig;

  final List<String> _avaiablePerOneLangCodesBottom = [];
  List<String> get avaiablePerOneLangCodesBottom => _avaiablePerOneLangCodesBottom;

  final List<String> _avaiablePerTwoLangCodesTop = [];
  List<String> get avaiablePerTwoLangCodesTop => _avaiablePerTwoLangCodesTop;

  bool _isULCAConfigLoaded = false;
  bool get isULCAConfigLoaded => _isULCAConfigLoaded;
  void changeIsULCAConfigLoaded({required bool isULCAConfigLoaded}) {
    _isULCAConfigLoaded = isULCAConfigLoaded;
    update();
  }

  void fetchULCAConfig() {
    Map<dynamic, dynamic> payloadToSend = GlobalAppConstants.deepCopyMap(ulcaConfigRequestPayload);

    payloadToSend['pipelineTasks'] = [taskTypeASR, taskTypeNMT, taskTypeTTS];
    payloadToSend['pipelineRequestConfig']['submitter'] = submitterToUse;

    _conversationScreenAPICalls.sendULCAConfigRequest(payload: payloadToSend).then((response) {
      _ulcaConfig = GlobalAppConstants.deepCopyMap(response);
      changeIsULCAConfigLoaded(isULCAConfigLoaded: true);

      calcPerOneLangs();
    });
  }

  void calcPerOneLangs() {
    _avaiablePerOneLangCodesBottom.clear();
    List<dynamic> languagesParameterInULCAConfig = _ulcaConfig['languages'];

    for (Map<dynamic, dynamic> eachLanguageDict in languagesParameterInULCAConfig) {
      _avaiablePerOneLangCodesBottom.add(eachLanguageDict['sourceLanguage'].toString());
    }

    // If english is available move it to first index
    if (_avaiablePerOneLangCodesBottom.contains('en')) {
      _avaiablePerOneLangCodesBottom.remove('en');
      _avaiablePerOneLangCodesBottom.sort();
      _avaiablePerOneLangCodesBottom.insert(0, 'en');
    } else {
      _avaiablePerOneLangCodesBottom.sort();
    }
  }

  void calcPerTwoLangsBasedOnPerOneSelection({required String personOneSelectedLangCodeInUI}) {
    List<dynamic> languagesParameterInULCAConfig = _ulcaConfig['languages'];
    _avaiablePerTwoLangCodesTop.clear();
    List<dynamic> availablePerTwoLangCodes =
        languagesParameterInULCAConfig.firstWhere((eachDict) => eachDict['sourceLanguage'] == personOneSelectedLangCodeInUI)['targetLanguageList'];

    for (String eachLangCode in availablePerTwoLangCodes) {
      _avaiablePerTwoLangCodesTop.add(eachLangCode.toString());
    }

    if (_avaiablePerTwoLangCodesTop.contains('en')) {
      _avaiablePerTwoLangCodesTop.remove('en');
      _avaiablePerTwoLangCodesTop.sort();
      _avaiablePerTwoLangCodesTop.insert(0, 'en');
    } else {
      _avaiablePerTwoLangCodesTop.sort();
    }
  }
}
