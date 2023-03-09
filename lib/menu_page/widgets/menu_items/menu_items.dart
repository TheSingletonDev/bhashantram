import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../menu_screen_controller.dart';
import 'menu_constants.dart';
import 'menu_items_of_contribute.dart';
import 'menu_items_of_services.dart';
import 'model_service_contribute_btn.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 15,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(children: [
          // Listing Services and Contribution Menu Items based on Services/Contribute button selection
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
            child: GetBuilder<MenuScreenController>(builder: (menuScreenController) {
              final Color primaryColor = Theme.of(context).colorScheme.primary;
              final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

              Color servicesBtnColor = menuScreenController.isServiceButtonClicked ? onPrimaryColor : primaryColor;
              Color contributeBtnColor = menuScreenController.isContributionButtonClicked ? onPrimaryColor : primaryColor;

              final Color serviceBtnAndBtnBorderColor = menuScreenController.isServiceButtonClicked ? primaryColor : Colors.transparent;
              final Color contributeBtnAndBtnBorderColor = menuScreenController.isContributionButtonClicked ? primaryColor : Colors.transparent;

              return Row(
                children: [
                  // Services Button
                  AnimatedContainer(
                    height: 60.w,
                    width: menuScreenController.currentServiceButtonWidthForAnimation,
                    duration: const Duration(milliseconds: 200),
                    onEnd: () {
                      if (menuScreenController.isServiceButtonClicked) {
                        menuScreenController.changeServiceBtnName(serviceBtnName: serviceBtnText);
                        menuScreenController.changeShouldServicesMenuItemsVisible(shouldServicesMenuItemsVisible: true);
                      } else {
                        menuScreenController.changeServiceBtnName(serviceBtnName: '');
                      }
                    },
                    child: ServiceAndContributeButtonModel(
                      btnColor: servicesBtnColor,
                      btnAndBtnBorderColor: serviceBtnAndBtnBorderColor,
                      btnText: menuScreenController.serviceBtnName,
                      iconData: Icons.groups_2_outlined,
                      iconSize: 45.w,
                      onPressed: () {
                        // if condition is used because it should only toggle when the button's current state is unselected so that it can be selected
                        // if this is not used, then when button is selected, it will get unselected.
                        if (!menuScreenController.isServiceButtonClicked) {
                          menuScreenController.changeContributeBtnName(contributeBtnName: '');
                          menuScreenController.changeShouldContributeMenuItemsVisible(shouldContributeMenuItemsVisible: false);
                          menuScreenController.changeIsServiceButtonClicked(isServiceButtonClicked: !menuScreenController.isServiceButtonClicked);
                          menuScreenController.changeCurrentServiceButtonWidthForAnimation(
                              currentServiceButtonWidthForAnimation: serviceContributeBtnMaxLen);
                          menuScreenController.changeCurrentContributionButtonWidthForAnimation(
                              currentContributionButtonWidthForAnimation: serviceContributeBtnMinLen);

                          menuScreenController.changeContributeMenuContainerWidthForAnimation(contributeMenuContainerWidthForAnimation: 0.sw);
                          menuScreenController.changeServiceMenuContainerWidthForAnimation(serviceMenuContainerWidthForAnimation: 1.sw);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 30.w),

                  //Contribution Button
                  AnimatedContainer(
                    height: 60.w,
                    width: menuScreenController.currentContributionButtonWidthForAnimation,
                    duration: const Duration(milliseconds: 200),
                    onEnd: () {
                      if (menuScreenController.isContributionButtonClicked) {
                        menuScreenController.changeContributeBtnName(contributeBtnName: contributeBtnText);
                        menuScreenController.changeShouldContributeMenuItemsVisible(shouldContributeMenuItemsVisible: true);
                      } else {
                        menuScreenController.changeContributeBtnName(contributeBtnName: '');
                      }
                    },
                    child: ServiceAndContributeButtonModel(
                      btnColor: contributeBtnColor,
                      btnAndBtnBorderColor: contributeBtnAndBtnBorderColor,
                      btnText: menuScreenController.contributeBtnName,
                      iconData: Icons.downloading_rounded,
                      iconSize: 40.w,
                      onPressed: () {
                        // if condition is used because it should only toggle when the button's current state is unselected so that it can be selected
                        // if this is not used, then when button is selected, and we click on it, it will get unselected.
                        if (!menuScreenController.isContributionButtonClicked) {
                          menuScreenController.changeServiceBtnName(serviceBtnName: '');
                          menuScreenController.changeShouldServicesMenuItemsVisible(shouldServicesMenuItemsVisible: false);
                          menuScreenController.changeIsContributionButtonClicked(
                              isContributionButtonClicked: !menuScreenController.isContributionButtonClicked);
                          menuScreenController.changeCurrentContributionButtonWidthForAnimation(
                              currentContributionButtonWidthForAnimation: serviceContributeBtnMaxLen);
                          menuScreenController.changeCurrentServiceButtonWidthForAnimation(
                              currentServiceButtonWidthForAnimation: serviceContributeBtnMinLen);

                          menuScreenController.changeServiceMenuContainerWidthForAnimation(serviceMenuContainerWidthForAnimation: 0.sw);
                          menuScreenController.changeContributeMenuContainerWidthForAnimation(contributeMenuContainerWidthForAnimation: 1.sw);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            // If more items to be included, this can become the child of SingleChildScrollView so that whole column is scrollable
            child: GetBuilder<MenuScreenController>(builder: (menuScreenController) {
              return Row(
                children: [
                  AnimatedBaseContainer(
                    animatedContainerWidth: menuScreenController.serviceMenuContainerWidthForAnimation,
                    animatedOpacity: menuScreenController.shouldServicesMenuItemsVisible ? 1 : 0,
                    visibility: menuScreenController.shouldServicesMenuItemsVisible,
                    child: const MenuItemServices(),
                  ),
                  AnimatedBaseContainer(
                    animatedContainerWidth: menuScreenController.contributeMenuContainerWidthForAnimation,
                    animatedOpacity: menuScreenController.shouldContributeMenuItemsVisible ? 1 : 0,
                    visibility: menuScreenController.shouldContributeMenuItemsVisible,
                    child: const MenuItemContribute(),
                  ),
                ],
              );
            }),
          ),
        ]),
      ),
    );
  }
}

class AnimatedBaseContainer extends StatelessWidget {
  final double animatedContainerWidth;
  final double animatedOpacity;
  final bool visibility;
  final Widget child;

  const AnimatedBaseContainer({
    super.key,
    required this.animatedContainerWidth,
    required this.animatedOpacity,
    required this.visibility,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: animatedContainerWidth,
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        opacity: animatedOpacity,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: Visibility(visible: visibility, child: child),
      ),
    );
  }
}
