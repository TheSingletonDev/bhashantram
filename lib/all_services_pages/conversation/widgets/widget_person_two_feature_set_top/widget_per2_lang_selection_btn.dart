import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhashantram/all_services_pages/conversation/conversation_controller.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_two_feature_set_top/per2_ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../global/enum_global.dart';
import '../../../../global/global_app_constants.dart';

class PersonTwoLanguageSelectionBtn extends StatelessWidget {
  const PersonTwoLanguageSelectionBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
      String btnTxt = personTwoUIController.isAvaiableLanguageDialogOpen
          ? 'Close    X'
          : personTwoUIController.currentSelectedLanguageCode.isEmpty
              ? 'Select'
              : GlobalAppConstants.getLanguageCodeOrName(
                  value: personTwoUIController.currentSelectedLanguageCode, returnWhat: LANGUAGE_MAP.languageName);
      Color btnColor = personTwoUIController.isAvaiableLanguageDialogOpen
          ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.9)
          : Theme.of(context).colorScheme.onPrimary.withOpacity(0.75);

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        height: double.infinity,
        width: 0.27.sw,
        child: FilledButton(
          onPressed: () {
            Get.find<ConversationController>()
                .calcPerTwoLangsBasedOnPerOneSelection(personOneSelectedLangCodeInUI: Get.find<PersonOneUIController>().currentSelectedLanguageCode);
            Get.find<PersonOneUIController>().changeIsAvaiableLanguageDialogOpen(isAvaiableLanguageDialogOpen: false);
            personTwoUIController.changeIsAvaiableLanguageDialogOpen(
                isAvaiableLanguageDialogOpen: !personTwoUIController.isAvaiableLanguageDialogOpen);
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
