import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:get/get.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../global/global_app_constants.dart';
import 'widgets/widget_person_two_feature_set_top/per2_ui_controller.dart';

class SocketConnectService extends GetxController {
  late Socket _socket;
  late PersonOneUIController _personOneUIController;
  late PersonTwoUIController _personTwoUIController;
  String _ttsResponse = '';
  StreamSubscription<Uint8List>? _listerner;
  final int silenceSize = 40;

  bool _isReqForPerOneAtBottom = true;

  @override
  void onInit() {
    super.onInit();
    _personOneUIController = Get.find();
    _personTwoUIController = Get.find();

    //Socket Dhruva
    _socket = io(socketURL, OptionBuilder().setTransports(['websocket', 'polling']).disableAutoConnect().setAuth({"authorization": const String.fromEnvironment('SOCKET_AUTH')}).build());

    socketStatus();
  }

  void socketEmit({required String emmittingStatus, required dynamic emittingData, required bool isDataToSend}) {
    isDataToSend ? _socket.emit(emmittingStatus, emittingData) : _socket.emit(emmittingStatus);
  }

  void socketConnect() {
    _socket.connect();
  }

  void socketDisconnect() {
    _socket.close();
    // _socket.disconnect();
  }

  void socketStatus() {
    _socket.onConnect((receivedData) {
      _personOneUIController.changeOutputBoxText(outputBoxText: 'Connecting');
      _personTwoUIController.changeOutputBoxText(outputBoxText: 'Connecting');
    });

    _socket.on('ready', (data) {
      _isReqForPerOneAtBottom
          ? () {
              _personOneUIController.changeOutputBoxText(outputBoxText: 'Listening...');
              _personTwoUIController.changeOutputBoxText(outputBoxText: 'Translating...');
            }()
          : () {
              _personOneUIController.changeOutputBoxText(outputBoxText: 'Translating...');
              _personTwoUIController.changeOutputBoxText(outputBoxText: 'Listening...');
            }();
    });

    _socket.on('connect-success', (data) {
      _personOneUIController.changeOutputBoxText(outputBoxText: 'Connect Success');
      _personTwoUIController.changeOutputBoxText(outputBoxText: 'Connect Success');
    });

    _socket.on('response', (data) {
      List<dynamic> responseList = data['pipelineResponse'];
      Map<dynamic, dynamic> asrResDict = responseList.firstWhere((eachRes) => eachRes['taskType'] == 'asr');
      Map<dynamic, dynamic> transResDict = responseList.firstWhere((eachRes) => eachRes['taskType'] == 'translation');
      Map<dynamic, dynamic> ttsResDict = responseList.firstWhere((eachRes) => eachRes['taskType'] == 'tts', orElse: () => {});

      String asrResponse = asrResDict['output'][0]['source'].toString();
      String transResponse = transResDict['output'][0]['target'].toString();
      _ttsResponse = ttsResDict.isNotEmpty ? ttsResDict['audio'][0]['audioContent'].toString() : '';

      print("ASR: $asrResponse");
      print("Translation: $transResponse");
      print("TTS: $_ttsResponse");

      _isReqForPerOneAtBottom
          ? () {
              _personOneUIController.changeOutputBoxText(outputBoxText: asrResponse);
              _personTwoUIController.changeOutputBoxText(outputBoxText: transResponse);
            }()
          : () {
              _personTwoUIController.changeOutputBoxText(outputBoxText: asrResponse);
              _personOneUIController.changeOutputBoxText(outputBoxText: transResponse);
            }();
    });

    _socket.on('terminate', (data) {
      // _personOneUIController.changeOutputBoxText(outputBoxText: 'Terminate');
      // _personTwoUIController.changeOutputBoxText(outputBoxText: 'Terminate');
    });

    _socket.onDisconnect((data) {
      // _personOneUIController.changeOutputBoxText(outputBoxText: 'Disconnected');
      // _personTwoUIController.changeOutputBoxText(outputBoxText: 'Disconnected');
    });

    // _socket.onAny(
    //   (event, data) {
    //     if (event != 'response') {
    //       print('onAny: $event, $data');
    //     }
    //   },
    // );
  }

  void recordVoice({required List<Map<dynamic, dynamic>> socketTaskSeqToSend, required bool isReqForPerOneAtBottom}) {
    _ttsResponse = '';
    Permission.microphone.request().then((permission) {
      _isReqForPerOneAtBottom = isReqForPerOneAtBottom;
      if (permission.isGranted) {
        socketConnect();
        _socket.emit('start', [socketTaskSeqToSend]);

        Future.delayed(const Duration(milliseconds: 50)).then((_) {
          MicStream.shouldRequestPermission(true);

          MicStream.microphone(
                  audioSource: AudioSource.DEFAULT,
                  // sampleRate: 44100,
                  channelConfig: ChannelConfig.CHANNEL_IN_MONO,
                  audioFormat: AudioFormat.ENCODING_PCM_16BIT)
              .then((stream) {
            List<int> checkSilenceList = List.generate(silenceSize, (i) => 0);
            _listerner = stream?.listen((value) {
              double meanSquared = meanSquare(value.buffer.asInt8List());
              _socket.emit('data', [
                {
                  "audio": [
                    {"audioContent": value}
                  ]
                },
                {"response_depth": 2},
                false, // Clear Server Data Flag
                false // Let Server know, user finised speaking
              ]);

              if (meanSquared >= 0.8) {
                checkSilenceList.add(0);
              }
              if (meanSquared < 0.8) {
                checkSilenceList.add(1);

                if (checkSilenceList.length > silenceSize) {
                  checkSilenceList = checkSilenceList.sublist(checkSilenceList.length - silenceSize);
                }
                int sumValue = checkSilenceList.reduce((value, element) => value + element);
                if (sumValue == silenceSize) {
                  print('Clearing Buffer');
                  _socket.emit('data', [
                    {
                      "audio": [
                        {"audioContent": value}
                      ]
                    },
                    {"response_depth": 2},
                    false, // Clear Server Data Flag
                    false // Let Server know, user finised speaking
                  ]);

                  checkSilenceList.clear();
                }
              }
            });
          });
        });
      } else {}
    });
  }

  void stopRecording() {
    if (_listerner != null) {
      _listerner?.cancel();
    }

    _socket.emit('data', [
      null,
      {"response_depth": 2},
      true,
      true
    ]);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      //Dont dispose here. close means one person stopped and when next person speak same _socket can be used. If disposed, then cant use. Dispose is done in onClose
      _socket.close();
      if (_ttsResponse.isNotEmpty) {
        getApplicationDocumentsDirectory().then((directory) {
          String ttsAudioFilePathToWrite = '${directory.path}/TTSAudio${DateTime.now().millisecondsSinceEpoch}.wav';
          File(ttsAudioFilePathToWrite).writeAsBytes(base64Decode(_ttsResponse)).then((ttsAudioFile) {
            ttsAudioFile.exists().then((doesFileExists) {
              if (doesFileExists) {
                AudioPlayer().play(DeviceFileSource(ttsAudioFilePathToWrite)).then((_) => AudioPlayer().play(AssetSource('audio/beep.mp3')));
              } else {}
            });
          });
        });
      }
    });
  }

  double meanSquare(Int8List value) {
    var sqrdValue = 0;
    for (int indValue in value) {
      sqrdValue = indValue * indValue;
    }
    return (sqrdValue / value.length) * 1000;
  }

  @override
  void onClose() {
    closeEverything();
    super.onClose();
  }

  void closeEverything() async {
    print('CLosing this controller');

    await _listerner?.cancel();
    _socket.dispose();
    var directory = await getApplicationDocumentsDirectory();
    var doesDirExists = await directory.exists();
    if (doesDirExists) {
      directory.list(recursive: true).forEach((eachFile) {
        if (eachFile is File) {
          eachFile.deleteSync();
        }
      });
    }
  }
}
