import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonTwoLanguageSelectionBtn extends StatelessWidget {
  const PersonTwoLanguageSelectionBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: double.infinity,
      width: 0.27.sw,
      child: FilledButton(
        onPressed: () => print('Lanugage Button Pressed'),
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimary.withOpacity(0.75))),
        child: AutoSizeText(
          'English',
          style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
