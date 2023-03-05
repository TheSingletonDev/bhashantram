import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../widget_male_female_base_btn.dart';
import 'per1_ui_controller.dart';

class PersonOneMaleFemaleSwitch extends StatelessWidget {
  const PersonOneMaleFemaleSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      height: double.infinity,
      width: 0.15.sw, // Size of Combined Male/Female Button combo with onPrimary color
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75), borderRadius: BorderRadius.circular(30.w)),
      child: GetBuilder<PersonOneUIController>(builder: (personOneController) {
        Color primaryColor = Theme.of(context).colorScheme.primary;
        Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

        Color maleIconColor = personOneController.isFemaleBtnSelected ? primaryColor : onPrimaryColor;
        Color maleIconContainerColor = personOneController.isFemaleBtnSelected ? Colors.transparent : primaryColor;

        Color femaleIconColor = personOneController.isFemaleBtnSelected ? onPrimaryColor : primaryColor;
        Color femaleIconContainerColor = personOneController.isFemaleBtnSelected ? primaryColor : Colors.transparent;
        return MaleFemaleSelectBaseWidget(
          maleIconContainerColor: maleIconContainerColor,
          maleIconColor: maleIconColor,
          femaleIconContainerColor: femaleIconContainerColor,
          femaleIconColor: femaleIconColor,
          onPressedMaleBtn: () {
            if (personOneController.isFemaleBtnSelected) {
              personOneController.changeIsFemaleIconSelected(isFemaleBtnSelected: false);
            }
          },
          onPressedFemaleBtn: () {
            if (!personOneController.isFemaleBtnSelected) {
              personOneController.changeIsFemaleIconSelected(isFemaleBtnSelected: true);
            }
          },
        );
      }),
    );
  }
}
