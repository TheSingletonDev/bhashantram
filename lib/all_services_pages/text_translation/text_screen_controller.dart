import 'dart:io';

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
    });
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
