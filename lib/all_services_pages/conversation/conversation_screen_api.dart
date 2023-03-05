import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ConversationScreenAPICalls extends GetxController {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio();
  }

  @override
  void onClose() {
    _dio.close();
    super.onClose();
  }

  Future<dynamic> sendULCAConfigRequest({required url, required payload}) async {
    try {
      var response = await _dio.post(
        url,
        data: payload,
        options: Options(headers: {'Content-Type': 'application/json', 'Accept': '*/*'}),
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == 'Request Successful') {
          return response.data['data'];
        }
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<dynamic> sendPipelineComputeRequest({required url, required payload}) async {
    try {
      var response = await _dio.post(
        url,
        data: payload,
        options: Options(headers: {'Content-Type': 'application/json', 'Accept': '*/*'}),
      );

      if (response.statusCode == 200) {
        if (response.data['message'] == 'Request Successful') {
          return response.data['data'];
        }
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
