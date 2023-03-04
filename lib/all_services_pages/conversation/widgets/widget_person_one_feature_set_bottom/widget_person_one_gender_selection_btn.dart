import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'person_one_controller.dart';

class MaleFemaleSwitch extends StatelessWidget {
  const MaleFemaleSwitch({
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
      child: GetBuilder<PersonOneController>(builder: (personOneController) {
        Color primaryColor = Theme.of(context).colorScheme.primary;
        Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

        Color maleIconColor = personOneController.isFemaleBtnSelected ? primaryColor : onPrimaryColor;
        Color maleIconContainerColor = personOneController.isFemaleBtnSelected ? Colors.transparent : primaryColor;

        Color femaleIconColor = personOneController.isFemaleBtnSelected ? onPrimaryColor : primaryColor;
        Color femaleIconContainerColor = personOneController.isFemaleBtnSelected ? primaryColor : Colors.transparent;

        return Row(
          children: [
            // Male Button
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.w),
                decoration: BoxDecoration(color: maleIconContainerColor, borderRadius: BorderRadius.circular(50.w)),
                child: IconButton(
                  onPressed: () {
                    if (personOneController.isFemaleBtnSelected) {
                      personOneController.changeIsFemaleIconSelected(isFemaleBtnSelected: false);
                    }
                  },
                  padding: EdgeInsets.only(bottom: 2.h),
                  icon: Icon(Icons.male_rounded, color: maleIconColor),
                ),
              ),
            ),

            // Female Button
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.w),
                decoration: BoxDecoration(color: femaleIconContainerColor, borderRadius: BorderRadius.circular(50.w)),
                child: IconButton(
                  onPressed: () {
                    if (!personOneController.isFemaleBtnSelected) {
                      personOneController.changeIsFemaleIconSelected(isFemaleBtnSelected: true);
                    }
                  },
                  padding: EdgeInsets.only(bottom: 2.h),
                  icon: Icon(Icons.female_rounded, color: femaleIconColor),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
