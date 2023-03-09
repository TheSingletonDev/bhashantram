import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PersonTwoUIController extends GetxController {
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

  bool _shallActivatePersonTwoControls = false;
  bool get shallActivatePersonTwoControls => _shallActivatePersonTwoControls;
  void changeShallActivatePersonTwoControls({required bool shallActivatePersonTwoControls}) {
    _shallActivatePersonTwoControls = shallActivatePersonTwoControls;
    update();
  }

  String _currentSelectedLanguageCode = '';
  String get currentSelectedLanguageCode => _currentSelectedLanguageCode;
  void changeCurrentSelectedLanguageCode({required String currentSelectedLanguageCode}) {
    _currentSelectedLanguageCode = currentSelectedLanguageCode;
    update();
  }

  bool _isAvaiableLanguageDialogOpen = false;
  bool get isAvaiableLanguageDialogOpen => _isAvaiableLanguageDialogOpen;
  void changeIsAvaiableLanguageDialogOpen({required bool isAvaiableLanguageDialogOpen}) {
    _isAvaiableLanguageDialogOpen = isAvaiableLanguageDialogOpen;
    update();
  }
}
