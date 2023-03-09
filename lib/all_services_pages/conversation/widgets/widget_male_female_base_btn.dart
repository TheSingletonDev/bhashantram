import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaleFemaleSelectBaseWidget extends StatelessWidget {
  const MaleFemaleSelectBaseWidget({
    super.key,
    required this.maleIconContainerColor,
    required this.maleIconColor,
    required this.femaleIconContainerColor,
    required this.femaleIconColor,
    required this.onPressedMaleBtn,
    required this.onPressedFemaleBtn,
  });

  final Color maleIconContainerColor;
  final Color maleIconColor;
  final Color femaleIconContainerColor;
  final Color femaleIconColor;
  final void Function()? onPressedMaleBtn;
  final void Function()? onPressedFemaleBtn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Male Button
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.w),
            decoration: BoxDecoration(color: maleIconContainerColor, borderRadius: BorderRadius.circular(50.w)),
            child: IconButton(
              onPressed: onPressedMaleBtn,
              padding: EdgeInsets.only(bottom: 2.h),
              icon: Icon(Icons.male_rounded, color: maleIconColor, size: 30.w),
            ),
          ),
        ),

        // Female Button
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.w),
            decoration: BoxDecoration(color: femaleIconContainerColor, borderRadius: BorderRadius.circular(50.w)),
            child: IconButton(
              onPressed: onPressedFemaleBtn,
              padding: EdgeInsets.only(bottom: 2.h),
              icon: Icon(Icons.female_rounded, color: femaleIconColor, size: 30.w),
            ),
          ),
        ),
      ],
    );
  }
}
