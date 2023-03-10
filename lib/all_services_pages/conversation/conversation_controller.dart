import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bhashantram/all_services_pages/conversation/conversation_screen_api.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_recorder_controller.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../global/global_app_constants.dart';
import 'conversation_constants.dart';
import 'widgets/widget_person_two_feature_set_top/per2_recorder_controller.dart';
import 'widgets/widget_person_two_feature_set_top/per2_ui_controller.dart';

class ConversationController extends GetxController {
  late final ConversationScreenAPICalls _conversationScreenAPICalls;
  late final PersonOneUIController _personOneUIController;
  late final PersonTwoUIController _personTwoUIController;
  late String _ttsAudioFilePathToWrite;

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

  void sendS2SPipelineReq({required bool isReqForPersonAtBottom}) {
    try {
      String asrServiceID = '';
      String translationServiceID = '';
      String ttsServiceID = '';
      // isReqForPersonAtBottom
      //     ? () {
      //         _personTwoUIController.changeASROutput(asrOutput: '');
      //         _personTwoUIController.changeTranslationOutput(translationOutput: '');
      //       }()
      //     : () {
      //         _personOneUIController.changeASROutput(asrOutput: '');
      //         _personOneUIController.changeTranslationOutput(translationOutput: '');
      //       }();
      for (Map<dynamic, dynamic> eachTaskDict in _ulcaConfig['pipelineResponseConfig']) {
        if (eachTaskDict['taskType'] == 'asr') {
          List<dynamic> asrDictConfig = eachTaskDict['config'];
          Map<dynamic, dynamic> selectedLangASRDict = asrDictConfig.firstWhere((eachASRLangDict) =>
              eachASRLangDict['language']['sourceLanguage'] ==
              (isReqForPersonAtBottom
                  ? _personOneUIController.currentSelectedLanguageCode.toString()
                  : _personTwoUIController.currentSelectedLanguageCode.toString()));
          asrServiceID = selectedLangASRDict['serviceId'];
        }
        if (eachTaskDict['taskType'] == 'translation') {
          List<dynamic> translationDictConfig = eachTaskDict['config'];
          Map<dynamic, dynamic> selectedLangTransDict = translationDictConfig.firstWhere((eachTranslateLangDict) =>
              eachTranslateLangDict['language']['sourceLanguage'] ==
                  (isReqForPersonAtBottom
                      ? _personOneUIController.currentSelectedLanguageCode.toString()
                      : _personTwoUIController.currentSelectedLanguageCode.toString()) &&
              eachTranslateLangDict['language']['targetLanguage'] ==
                  (isReqForPersonAtBottom
                      ? _personTwoUIController.currentSelectedLanguageCode.toString()
                      : _personOneUIController.currentSelectedLanguageCode.toString()));
          translationServiceID = selectedLangTransDict['serviceId'];
        }
        if (eachTaskDict['taskType'] == 'tts') {
          List<dynamic> ttsDictConfig = eachTaskDict['config'];
          Map<dynamic, dynamic> selectedLangTTSDict = ttsDictConfig.firstWhere((eachTTSLangDict) =>
              eachTTSLangDict['language']['sourceLanguage'] ==
              (isReqForPersonAtBottom
                  ? _personTwoUIController.currentSelectedLanguageCode.toString()
                  : _personOneUIController.currentSelectedLanguageCode.toString()));
          ttsServiceID = selectedLangTTSDict['serviceId'];
        }
      }

      Map<dynamic, dynamic> asrComputePayloadToSend = GlobalAppConstants.deepCopyMap(asrComputePayload);
      asrComputePayloadToSend['serviceId'] = asrServiceID;
      asrComputePayloadToSend['config']['language']['sourceLanguage'] = isReqForPersonAtBottom
          ? _personOneUIController.currentSelectedLanguageCode.toString()
          : _personTwoUIController.currentSelectedLanguageCode.toString();

      Map<dynamic, dynamic> trnaslationComputePayloadToSend = GlobalAppConstants.deepCopyMap(trnaslationComputePayload);
      trnaslationComputePayloadToSend['serviceId'] = translationServiceID;
      trnaslationComputePayloadToSend['config']['language']['sourceLanguage'] =
          isReqForPersonAtBottom ? _personOneUIController.currentSelectedLanguageCode : _personTwoUIController.currentSelectedLanguageCode;
      trnaslationComputePayloadToSend['config']['language']['targetLanguage'] =
          isReqForPersonAtBottom ? _personTwoUIController.currentSelectedLanguageCode : _personOneUIController.currentSelectedLanguageCode;

      Map<dynamic, dynamic> ttsComputePayloadToSend = GlobalAppConstants.deepCopyMap(ttsComputePayload);
      ttsComputePayloadToSend['serviceId'] = ttsServiceID;
      ttsComputePayloadToSend['config']['language']['sourceLanguage'] =
          isReqForPersonAtBottom ? _personTwoUIController.currentSelectedLanguageCode : _personOneUIController.currentSelectedLanguageCode;
      ttsComputePayloadToSend['config']['gender'] =
          (isReqForPersonAtBottom ? _personOneUIController.isFemaleBtnSelected : _personTwoUIController.isFemaleBtnSelected) ? 'female' : 'male';

      Map<dynamic, dynamic> asrComputeInputDataToSend = GlobalAppConstants.deepCopyMap(asrComputeInputData);
      asrComputeInputDataToSend['audio'][0]['audioContent'] = isReqForPersonAtBottom
          ? Get.find<PersonOneRecorderController>().base64EncodedAudioContent
          : Get.find<PersonTwoRecorderController>().base64EncodedAudioContent;

      Map<dynamic, dynamic> s2sComputePayloadToSend = GlobalAppConstants.deepCopyMap(s2sComputePayload);
      s2sComputePayloadToSend['pipelineTasks'] = [asrComputePayloadToSend, trnaslationComputePayloadToSend, ttsComputePayloadToSend];
      s2sComputePayloadToSend['inputData'] = asrComputeInputDataToSend;

      _conversationScreenAPICalls
          .sendPipelineComputeRequest(
        computeURL: _ulcaConfig['pipelineInferenceAPIEndPoint']['callbackUrl'],
        computeAPIKeyName: _ulcaConfig['pipelineInferenceAPIEndPoint']['inferenceApiKey']['name'],
        computeAPIKeyValue: _ulcaConfig['pipelineInferenceAPIEndPoint']['inferenceApiKey']['value'],
        computePayload: s2sComputePayloadToSend,
      )
          .then((response) {
        for (Map<dynamic, dynamic> eachResponseDict in response['pipelineResponse']) {
          if (eachResponseDict['taskType'] == 'asr') {
            isReqForPersonAtBottom
                ? _personOneUIController.changeOutputBoxText(outputBoxText: eachResponseDict['output'][0]['source'].toString())
                : _personTwoUIController.changeOutputBoxText(outputBoxText: eachResponseDict['output'][0]['source'].toString());
          }
          if (eachResponseDict['taskType'] == 'translation') {
            isReqForPersonAtBottom
                ? () {
                    _personTwoUIController.changeOutputBoxText(outputBoxText: eachResponseDict['output'][0]['target'].toString());
                  }()
                : () {
                    _personOneUIController.changeOutputBoxText(outputBoxText: eachResponseDict['output'][0]['target'].toString());
                  }();
          }
          if (eachResponseDict['taskType'] == 'tts') {
            var ttsFileAsBytes = base64Decode(eachResponseDict['audio'][0]['audioContent']);
            // AudioPlayer().play(BytesSource(ttsFileAsBytes));

            getApplicationDocumentsDirectory().then((directory) {
              _ttsAudioFilePathToWrite = '${directory.path}/TTSAudio${DateTime.now().millisecondsSinceEpoch}.wav';
              File(_ttsAudioFilePathToWrite).writeAsBytes(ttsFileAsBytes).then((ttsAudioFile) {
                ttsAudioFile.exists().then((doesFileExists) {
                  if (doesFileExists) {
                    AudioPlayer().play(DeviceFileSource(_ttsAudioFilePathToWrite)).then((_) => AudioPlayer().play(AssetSource('audio/beep.mp3')));
                  } else {
                    print('File could not be written!');
                  }
                });
              });
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
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
