import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceAndContributeButtonModel extends StatelessWidget {
  const ServiceAndContributeButtonModel({
    super.key,
    required this.btnColor,
    // required this.materialServiceBtnColor,
    required this.btnText,
    required this.onPressed,
    required this.iconData,
    required this.iconSize,
    required this.btnAndBtnBorderColor,
  });

  final void Function()? onPressed;
  final IconData iconData;
  final double iconSize;
  final String btnText;
  final Color btnColor;
  final Color btnAndBtnBorderColor;
  // final MaterialStatePropertyAll<Color> materialServiceBtnColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(iconData, size: iconSize, color: btnColor),
      label: AutoSizeText(
        btnText,
        minFontSize: 23.w,
        stepGranularity: 1.w,
        style: GoogleFonts.poppins(color: btnColor, fontWeight: FontWeight.w500),
      ),
      // style: ButtonStyle(backgroundColor: materialServiceBtnColor),
      style: OutlinedButton.styleFrom(backgroundColor: btnAndBtnBorderColor, side: BorderSide(color: btnAndBtnBorderColor, style: BorderStyle.solid)),
    );
  }
}
