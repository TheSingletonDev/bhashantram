import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';

import 'package:bhashantram/all_services_pages/text_translation/text_screen_api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../global/global_app_constants.dart';

class TextScreenController extends GetxController {
  Map<dynamic, dynamic> _ulcaConfig = {};
  Map<dynamic, dynamic> get ulcaConfig => _ulcaConfig;

  bool _isULCAConfigLoaded = false;
  bool get isULCAConfigLoaded => _isULCAConfigLoaded;
  void changeIsULCAConfigLoaded({required bool isULCAConfigLoaded}) {
    _isULCAConfigLoaded = isULCAConfigLoaded;
    update();
  }

  String _currentSelectedSourceLangCode = '';
  String get currentSelectedSourceLangCode => _currentSelectedSourceLangCode;
  void changeCurrentSelectedSourceLangCode({required String currentSelectedSourceLangCode}) {
    _currentSelectedSourceLangCode = currentSelectedSourceLangCode;
    update();
  }

  String _currentSelectedTargetLangCode = '';
  String get currentSelectedTargetLangCode => _currentSelectedTargetLangCode;
  void changeCurrentSelectedTargetLangCode({required String currentSelectedTargetLangCode}) {
    _currentSelectedTargetLangCode = currentSelectedTargetLangCode;
    update();
  }

  final List<String> _availableSourceLangCodesList = [];
  List<String> get availableSourceLanguages => _availableSourceLangCodesList;

  final List<dynamic> _correspondingTargetLangCodesList = [];
  List<dynamic> get correspondingTargetLangCodesList => _correspondingTargetLangCodesList;
  void changeCorrespondingTargetLangCodesList({required correspondingTargetLangCodesList}) {
    _correspondingTargetLangCodesList.clear();
    _correspondingTargetLangCodesList.addAll(correspondingTargetLangCodesList);
    update();
  }

  bool _isSourceLangPane = true;
  bool get isSourceLangPane => _isSourceLangPane;

  bool _showLanguageSelectionPane = false;
  bool get showLanguageSelectionPane => _showLanguageSelectionPane;
  void changeShowLanguageSelectionPane({required bool showLanguageSelectionPane, required bool isSourceLangPane}) {
    _showLanguageSelectionPane = showLanguageSelectionPane;
    _isSourceLangPane = isSourceLangPane;
    update();
  }

  late final TextScreenAPICalls _textScreenAPICalls;

  @override
  void onInit() {
    super.onInit();
    _textScreenAPICalls = Get.find();
  }

  void fetchULCAConfigForTextScreen() {
    Map<dynamic, dynamic> payloadToSend = GlobalAppConstants.deepCopyMap(ulcaConfigRequestPayload);

    payloadToSend['pipelineTasks'] = [taskTypeNMT, taskTypeTTS];
    payloadToSend['pipelineRequestConfig']['pipelineId'] = pipelineIdMeitY;

    _textScreenAPICalls.sendULCAConfigRequest(payload: payloadToSend).then((response) {
      _ulcaConfig = GlobalAppConstants.deepCopyMap(response);
      changeIsULCAConfigLoaded(isULCAConfigLoaded: true);
      if (_ulcaConfig.isNotEmpty) {
        chooseRandomLangCodes();
      } else {
        print('ULCA Config is empty!');
      }
    });
  }

  void chooseRandomLangCodes() {
    _availableSourceLangCodesList.clear();
    List<dynamic> allAvailableSourceLangs = _ulcaConfig['languages'];
    for (Map<dynamic, dynamic> eachLanguageDict in allAvailableSourceLangs) {
      _availableSourceLangCodesList.add(eachLanguageDict['sourceLanguage'].toString());
    }
    // If english is available move it to first index
    if (_availableSourceLangCodesList.contains('en')) {
      _availableSourceLangCodesList.remove('en');
      _availableSourceLangCodesList.sort();
      _availableSourceLangCodesList.insert(0, 'en');
    } else {
      _availableSourceLangCodesList.sort();
    }

    String randomlySelectedSourceLang = _availableSourceLangCodesList[Random().nextInt(_availableSourceLangCodesList.length)];
    changeCurrentSelectedSourceLangCode(currentSelectedSourceLangCode: randomlySelectedSourceLang);

    List<dynamic> correspondingTargetLangCodesList = allAvailableSourceLangs.firstWhere((eachLangDict) => eachLangDict['sourceLanguage'] == randomlySelectedSourceLang)['targetLanguageList'];
    changeCurrentSelectedTargetLangCode(currentSelectedTargetLangCode: correspondingTargetLangCodesList[Random().nextInt(correspondingTargetLangCodesList.length)]);
  }

  void correspondingTargetLangCodeForSelectedSourceLangCode() {
    List<dynamic> correspondingTargetLangCodesList = _ulcaConfig['languages'].firstWhere((eachLangDict) => eachLangDict['sourceLanguage'] == currentSelectedSourceLangCode)['targetLanguageList'];
    changeCurrentSelectedTargetLangCode(currentSelectedTargetLangCode: correspondingTargetLangCodesList[Random().nextInt(correspondingTargetLangCodesList.length)]);
    changeCorrespondingTargetLangCodesList(correspondingTargetLangCodesList: correspondingTargetLangCodesList);
  }

  @override
  void onClose() {
    getApplicationDocumentsDirectory().then((directory) {
      if (directory.existsSync()) {
        directory.listSync(recursive: true).forEach((entity) {
          if (entity is File) {
            entity.deleteSync();
          }
        });
      }
    });
    super.onClose();
  }
}
