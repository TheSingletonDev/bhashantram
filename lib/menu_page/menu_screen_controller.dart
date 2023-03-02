import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'widgets/menu_items/menu_constants.dart';

class MenuScreenController extends GetxController {
  bool _isServiceButtonClicked = true;
  bool get isServiceButtonClicked => _isServiceButtonClicked;
  void changeIsServiceButtonClicked({required bool isServiceButtonClicked}) {
    _isServiceButtonClicked = isServiceButtonClicked;
    _isContributionButtonClicked = !isServiceButtonClicked;
    update();
  }

  bool _isContributionButtonClicked = false;
  bool get isContributionButtonClicked => _isContributionButtonClicked;
  void changeIsContributionButtonClicked({required bool isContributionButtonClicked}) {
    _isContributionButtonClicked = isContributionButtonClicked;
    _isServiceButtonClicked = !isContributionButtonClicked;
    update();
  }

  double _currentServiceButtonWidthForAnimation = serviceContributeBtnMaxLen;
  double get currentServiceButtonWidthForAnimation => _currentServiceButtonWidthForAnimation;
  void changeCurrentServiceButtonWidthForAnimation({required double currentServiceButtonWidthForAnimation}) {
    _currentServiceButtonWidthForAnimation = currentServiceButtonWidthForAnimation;
    update();
  }

  double _currentContributionButtonWidthForAnimation = serviceContributeBtnMinLen;
  double get currentContributionButtonWidthForAnimation => _currentContributionButtonWidthForAnimation;
  void changeCurrentContributionButtonWidthForAnimation({required double currentContributionButtonWidthForAnimation}) {
    _currentContributionButtonWidthForAnimation = currentContributionButtonWidthForAnimation;
    update();
  }

  String _serviceBtnName = serviceBtnText;
  String get serviceBtnName => _serviceBtnName;
  void changeServiceBtnName({required String serviceBtnName}) {
    _serviceBtnName = serviceBtnName;
    update();
  }

  String _contributeBtnName = '';
  String get contributeBtnName => _contributeBtnName;
  void changeContributeBtnName({required String contributeBtnName}) {
    _contributeBtnName = contributeBtnName;
    update();
  }

  double _serviceMenuContainerWidthForAnimation = 1.sw;
  double get serviceMenuContainerWidthForAnimation => _serviceMenuContainerWidthForAnimation;
  void changeServiceMenuContainerWidthForAnimation({required double serviceMenuContainerWidthForAnimation}) {
    _serviceMenuContainerWidthForAnimation = serviceMenuContainerWidthForAnimation;
    update();
  }

  double _contributeMenuContainerWidthForAnimation = 0.sw;
  double get contributeMenuContainerWidthForAnimation => _contributeMenuContainerWidthForAnimation;
  void changeContributeMenuContainerWidthForAnimation({required double contributeMenuContainerWidthForAnimation}) {
    _contributeMenuContainerWidthForAnimation = contributeMenuContainerWidthForAnimation;
    update();
  }

  bool _shouldServicesMenuItemsVisible = true;
  bool get shouldServicesMenuItemsVisible => _shouldServicesMenuItemsVisible;
  void changeShouldServicesMenuItemsVisible({required bool shouldServicesMenuItemsVisible}) {
    _shouldServicesMenuItemsVisible = shouldServicesMenuItemsVisible;
    update();
  }

  bool _shouldContributeMenuItemsVisible = false;
  bool get shouldContributeMenuItemsVisible => _shouldContributeMenuItemsVisible;
  void changeShouldContributeMenuItemsVisible({required bool shouldContributeMenuItemsVisible}) {
    _shouldContributeMenuItemsVisible = shouldContributeMenuItemsVisible;
    update();
  }
}
