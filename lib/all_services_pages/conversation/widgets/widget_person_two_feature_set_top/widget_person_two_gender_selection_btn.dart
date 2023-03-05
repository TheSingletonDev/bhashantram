import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_two_feature_set_top/person_two_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../widget_male_female_base_btn.dart';

class PersonTwoMaleFemaleSwitch extends StatelessWidget {
  const PersonTwoMaleFemaleSwitch({
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
      child: GetBuilder<PersonTwoController>(builder: (personTwoController) {
        Color primaryColor = Theme.of(context).colorScheme.primary;
        Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

        Color maleIconColor = personTwoController.isFemaleBtnSelected ? primaryColor : onPrimaryColor;
        Color maleIconContainerColor = personTwoController.isFemaleBtnSelected ? Colors.transparent : primaryColor;

        Color femaleIconColor = personTwoController.isFemaleBtnSelected ? onPrimaryColor : primaryColor;
        Color femaleIconContainerColor = personTwoController.isFemaleBtnSelected ? primaryColor : Colors.transparent;

        return MaleFemaleSelectBaseWidget(
          maleIconContainerColor: maleIconContainerColor,
          maleIconColor: maleIconColor,
          femaleIconContainerColor: femaleIconContainerColor,
          femaleIconColor: femaleIconColor,
          onPressedMaleBtn: () {
            if (personTwoController.isFemaleBtnSelected) {
              personTwoController.changeIsFemaleIconSelected(isFemaleBtnSelected: false);
            }
          },
          onPressedFemaleBtn: () {
            if (!personTwoController.isFemaleBtnSelected) {
              personTwoController.changeIsFemaleIconSelected(isFemaleBtnSelected: true);
            }
          },
        );
      }),
    );
  }
}
