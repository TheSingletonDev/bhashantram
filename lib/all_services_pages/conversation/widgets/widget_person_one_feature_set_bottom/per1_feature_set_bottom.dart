import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../global/enum_global.dart';
import '../../../../global/global_app_constants.dart';
import '../../../../global/widget_snackbar.dart';
import '../../conversation_screen_controller.dart';
import '../widget_person_two_feature_set_top/per2_ui_controller.dart';
import 'per1_ui_controller.dart';
import '../widget_rec_fedback_pulse_wave.dart';
import 'widget_per1_gender_selection_btn.dart';
import 'widget_per1_lang_selection_btn.dart';
import 'widget_per1_mic_icon_btn.dart';
import 'package:clipboard/clipboard.dart';

class PersonOneFeatureSetBottom extends StatelessWidget {
  const PersonOneFeatureSetBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Base Container where either output will be shown or Language selection dialog
          GetBuilder<PersonOneUIController>(builder: (personOneUIController) {
            ConversationScreenController conversationController = Get.find();
            return Expanded(
              flex: 11,
              child: personOneUIController.isAvaiableLanguageDialogOpen
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.w),
                          topRight: Radius.circular(20.w),
                        ),
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 10.h),
                            child: AutoSizeText(
                              'Choose your Language:',
                              minFontSize: (15.w).toInt().toDouble(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 30.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: GridView.builder(
                                itemCount: conversationController.avaiablePerOneLangCodesBottom.length,
                                itemBuilder: (context, index) {
                                  String eachTargetLanguage = conversationController.avaiablePerOneLangCodesBottom.elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      personOneUIController.changeCurrentSelectedLanguageCode(currentSelectedLanguageCode: eachTargetLanguage);
                                      personOneUIController.changeIsAvaiableLanguageDialogOpen(isAvaiableLanguageDialogOpen: false);
                                      Get.find<PersonTwoUIController>().changeShallActivatePersonTwoControls(shallActivatePersonTwoControls: true);
                                    },
                                    child: Center(
                                      child: AutoSizeText(
                                        GlobalAppConstants.getLanguageCodeOrName(value: eachTargetLanguage, returnWhat: LANGUAGE_MAP.languageName),
                                        minFontSize: (10.w).toInt().toDouble(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(fontSize: 25.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 20.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                      child: personOneUIController.outputBoxText.isEmpty && Get.find<PersonTwoUIController>().outputBoxText.isEmpty
                          ? AutoSizeText(
                              'This is your box. Choose a language below and speak. What you speak will appear here after you stop speaking!',
                              minFontSize: (15.w).toInt().toDouble(),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 30.w, color: Theme.of(context).colorScheme.primary.withOpacity(0.2), fontWeight: FontWeight.w500),
                            )
                          : AutoSizeText(
                              personOneUIController.outputBoxText.toString(),
                              minFontSize: (15.w).toInt().toDouble(),
                              maxLines: 16,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 27.w, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                            ),
                    ),
            );
          }),
          SizedBox(height: 20.h),
          // Base Container with Mic Icon, Speaker, Copy buttons etc.
          Expanded(
            flex: 2,
            // Row with Mic icon and Circular Container with Copy Share etc/Recording Wave
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary),
                    child: GetBuilder<PersonOneUIController>(builder: (personOneController) {
                      return personOneController.isMicIconTappedDownAndHolding
                          ? const RecordingFeedbackPulseAndWave()
                          : Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    const PersonOneMaleFemaleSwitch(),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () {
                                                  if (personOneController.outputBoxText.isNotEmpty) {
                                                    FlutterClipboard.copy(personOneController.outputBoxText).then((_) {
                                                      showSnackbar(title: 'Success', message: 'Text copied to clipboard!', context: context);
                                                    });
                                                  }
                                                },
                                                highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                                                icon: Icon(
                                                  Icons.copy_rounded,
                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                  size: 30.w,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () {
                                                  print('Feedback');
                                                },
                                                highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                                icon: Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                                                  size: 30.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                const PersonOneLanguageSelectionBtn(),
                              ],
                            );
                    }),
                  ),
                ),
                SizedBox(width: 10.h),
                // Mic Icon
                GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
                  return Stack(
                    children: [
                      const PersonOneMicIconBtn(isSocketPreferred: isStreamingPreferred),
                      personTwoUIController.currentSelectedLanguageCode.isNotEmpty
                          ? const SizedBox()
                          : Container(
                              width: 0.15.sw,
                              height: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
                            )
                    ],
                  );
                })
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
