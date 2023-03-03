import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesPageHeaderContainer extends StatelessWidget {
  const ServicesPageHeaderContainer({
    super.key,
    required this.icon,
    required this.iconText,
  });

  final Icon icon;
  final AutoSizeText iconText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      height: 0.15.sh,
      child: Padding(
        padding: EdgeInsets.only(top: 20.w),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_circle_left_outlined, size: 40.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
                        SizedBox(width: 5.w),
                        AutoSizeText('Back',
                            style: GoogleFonts.poppins(
                                fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(width: 20.w),
                  iconText,
                  SizedBox(width: 15.w),
                ],
              ),
            ),
            SizedBox(height: 10.w),
          ],
        ),
      ),
    );
  }
}
