import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonOneFeatureSetTop extends StatelessWidget {
  const PersonOneFeatureSetTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20.w),
        // Base Container where output will be shown
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SizedBox(width: 20.w),
        // Base Container with Speaker, Copy buttons etc.
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 300.h, decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary)),
        )),
        SizedBox(width: 20.w),
      ],
    );
  }
}
