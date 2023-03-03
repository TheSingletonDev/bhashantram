import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ConversationScreenController extends GetxController {
  Color _currentColor = Colors.red;
  Color get getCurrentColor => _currentColor;
  void changeCurrentColor({required Color currentColor}) {
    _currentColor = currentColor;
    update();
  }

  bool _isMicIconTappedDownAndHolding = false;
  bool get isMicIconTappedDownAndHolding => _isMicIconTappedDownAndHolding;
  void changeIsMicIconTappedDown({required bool isMicIconTappedDownAndHolding}) {
    _isMicIconTappedDownAndHolding = isMicIconTappedDownAndHolding;
    update();
  }
}
