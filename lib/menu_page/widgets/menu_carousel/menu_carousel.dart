import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../menu_screen_controller.dart';
import 'menu_contribute_carousel_page.dart';
import 'menu_services_carousel.dart';

class MenuCarousel extends StatelessWidget {
  const MenuCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuScreenController>(builder: (menuScreenController) {
      return menuScreenController.isServiceButtonClicked ? const MenuServicesCarousel() : const MenuContributeCarousel();
    });
  }
}
