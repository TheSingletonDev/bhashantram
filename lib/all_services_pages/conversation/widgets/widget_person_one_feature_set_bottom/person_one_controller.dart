import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PersonOneController extends GetxController {
  bool _isMicIconTappedDownAndHolding = false;
  bool get isMicIconTappedDownAndHolding => _isMicIconTappedDownAndHolding;
  void changeIsMicIconTappedDown({required bool isMicIconTappedDownAndHolding}) {
    _isMicIconTappedDownAndHolding = isMicIconTappedDownAndHolding;
    update();
  }

  bool _isFemaleBtnSelected = true;
  bool get isFemaleBtnSelected => _isFemaleBtnSelected;
  void changeIsFemaleIconSelected({required isFemaleBtnSelected}) {
    _isFemaleBtnSelected = isFemaleBtnSelected;
    update();
  }
}
