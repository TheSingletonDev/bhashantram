import 'dart:convert';
import 'dart:io';

import 'package:bhashantram/all_services_pages/conversation/conversation_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class PersonOneRecorderController extends GetxController {
  late final Record _audioRec;

  String _base64EncodedAudioContent = '';
  String get base64EncodedAudioContent => _base64EncodedAudioContent;
  void changeBase64EncodedAudioContent({required String base64EncodedAudioContent}) {
    _base64EncodedAudioContent = base64EncodedAudioContent;
    update();
  }

  bool _wasRecordingSuccessAndComputeReqSent = false;
  bool get wasRecordingSuccessAndComputeReqSent => _wasRecordingSuccessAndComputeReqSent;
  void changeWasRecordingSuccessAndComputeReqSent({required bool wasRecordingSuccessAndComputeReqSent}) {
    _wasRecordingSuccessAndComputeReqSent = wasRecordingSuccessAndComputeReqSent;
    update();
  }

  bool _isRecording = false;
  bool get isRecording => _isRecording;
  void changeIsRecording({required bool isRecording}) {
    _isRecording = isRecording;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _audioRec = Record();
  }

  void startPerOneVoiceRecording() {
    try {
      Permission.microphone.request().then((permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          getApplicationDocumentsDirectory().then((directory) {
            _audioRec
                .start(
                  encoder: AudioEncoder.wav,
                  path: '${directory.path}/ASRAudio${DateTime.now().millisecondsSinceEpoch}.wav',
                )
                .then((_) => changeIsRecording(isRecording: true));
          });
        } else {
          print('Microphone permission not granted');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void stopPerOneRecording() {
    try {
      _audioRec.isRecording().then((isRecording) {
        if (isRecording) {
          _audioRec.stop().then((pathToFile) {
            _audioRec.dispose().then((_) {
              changeIsRecording(isRecording: false);
              print(pathToFile);
              if (pathToFile != null && pathToFile.isNotEmpty) {
                File perOneASRFile = File(pathToFile);
                perOneASRFile.exists().then((doesFileExists) {
                  if (doesFileExists) {
                    changeBase64EncodedAudioContent(base64EncodedAudioContent: base64Encode(perOneASRFile.readAsBytesSync()));
                    perOneASRFile.delete().then((_) {
                      perOneASRFile.exists().then((doesFileExists) {
                        doesFileExists ? print('File deletion failed') : print('File deleted successfully');
                      });
                    });
                    Get.find<ConversationController>().sendPersonOneS2SPipelineReq();

                    changeWasRecordingSuccessAndComputeReqSent(wasRecordingSuccessAndComputeReqSent: true);
                  }
                });
              }
            });
          });
        }
      });
    } catch (e) {
      print(e);
      changeWasRecordingSuccessAndComputeReqSent(wasRecordingSuccessAndComputeReqSent: false);
      changeBase64EncodedAudioContent(base64EncodedAudioContent: '');
      changeIsRecording(isRecording: false);
    }
  }
}
