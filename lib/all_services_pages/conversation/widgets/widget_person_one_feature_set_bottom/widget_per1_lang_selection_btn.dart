import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:bhashantram/global/global_app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../global/enum_global.dart';

class PersonOneLanguageSelectionBtn extends StatelessWidget {
  const PersonOneLanguageSelectionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonOneUIController>(builder: (personOneUIController) {
      String btnTxt = personOneUIController.isAvaiableLanguageDialogOpen
          ? 'Close    X'
          : personOneUIController.currentSelectedLanguageCode.isEmpty
              ? 'Select'
              : GlobalAppConstants.getLanguageCodeOrName(
                  value: personOneUIController.currentSelectedLanguageCode,
                  returnWhat: LANGUAGE_MAP.languageName,
                );
      Color btnColor = personOneUIController.isAvaiableLanguageDialogOpen
          ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.9)
          : Theme.of(context).colorScheme.onPrimary.withOpacity(0.75);

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        height: double.infinity,
        width: 0.27.sw,
        child: FilledButton(
          onPressed: () {
            personOneUIController.changeIsAvaiableLanguageDialogOpen(
                isAvaiableLanguageDialogOpen: !personOneUIController.isAvaiableLanguageDialogOpen);
          },
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(btnColor)),
          child: AutoSizeText(
            btnTxt,
            style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
          ),
        ),
      );
    });
  }
}
