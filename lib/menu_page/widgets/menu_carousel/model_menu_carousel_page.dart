import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuCarouselPageModel extends StatelessWidget {
  final Widget icon;
  final AutoSizeText iconText;
  final AutoSizeText pureText;

  const MenuCarouselPageModel({
    super.key,
    required this.icon,
    required this.iconText,
    required this.pureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: icon,
            ),
            SizedBox(width: 20.w),
            iconText,
          ],
        ),
        SizedBox(height: 35.h),
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: pureText,
        )
      ],
    );
  }
}
