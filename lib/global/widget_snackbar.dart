import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'enum_global.dart';

class SnackBarFormattedText extends StatelessWidget {
  final String text;
  final GETX_SNACK_BAR titleOrMessage;

  const SnackBarFormattedText({
    Key? key,
    required this.text,
    required this.titleOrMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = titleOrMessage == GETX_SNACK_BAR.title
        ? GoogleFonts.poppins(color: Theme.of(context).colorScheme.onPrimary, fontSize: 30.w, fontWeight: FontWeight.w600)
        : GoogleFonts.poppins(color: Theme.of(context).colorScheme.onPrimary, fontSize: 20.w, fontWeight: FontWeight.w400);
    return AutoSizeText(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: textStyle);
  }
}

class SnackBarFormattedIcon extends StatelessWidget {
  const SnackBarFormattedIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error_outline_rounded,
      color: Theme.of(context).colorScheme.onPrimary,
      size: 30.w,
    );
  }
}

void showSnackbar({required String title, required String message, required BuildContext context}) {
  Get.snackbar(
    '',
    '',
    titleText: SnackBarFormattedText(
      text: title,
      titleOrMessage: GETX_SNACK_BAR.title,
    ),
    messageText: SnackBarFormattedText(
      text: message,
      titleOrMessage: GETX_SNACK_BAR.message,
    ),
    icon: const SnackBarFormattedIcon(),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
    borderRadius: 10.w,
    margin: EdgeInsets.all(20.w),
    barBlur: 40,
    overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.30),
    overlayBlur: 1,
    colorText: Theme.of(context).colorScheme.primary,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
