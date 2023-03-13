import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'conversation_constants.dart';

class ConversationScreenAPICalls extends GetxController {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(BaseOptions(
        // baseUrl: ulcaBaseURL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) => true // Without this, if status code comes other than 200, DIO throws Exception
        ));
  }

  @override
  void onClose() {
    closeEverything();
    super.onClose();
  }

  Future<dynamic> sendULCAConfigRequest({required payload}) async {
    try {
      var response = await _dio.post(
        ulcaBaseURL + ulcaConfigReqURLPath,
        data: payload,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'ulcaApiKey': const String.fromEnvironment('ULCA_API_KEY'),
          'userID': const String.fromEnvironment('ULCA_USER_ID'),
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<dynamic> sendPipelineComputeRequest(
      {required computeURL, required computeAPIKeyName, required computeAPIKeyValue, required computePayload}) async {
    try {
      var response = await _dio.post(
        computeURL,
        data: computePayload,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          computeAPIKeyName: computeAPIKeyValue,
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  void closeEverything() async {
    _dio.close();
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
