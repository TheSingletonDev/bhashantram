import 'package:auto_size_text/auto_size_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemContainerModel extends StatelessWidget {
  final Icon icon;
  final AutoSizeText text;
  const MenuItemContainerModel({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50.w, horizontal: 20.w),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 40, cornerSmoothing: 1),
            borderAlign: BorderAlign.center,
            side: BorderSide(color: Theme.of(context).colorScheme.primary)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [SizedBox(height: 10.h), icon, text, SizedBox(height: 10.h)],
      ),
    );
  }
}
