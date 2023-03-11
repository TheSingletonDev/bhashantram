import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../global/enum_global.dart';
import '../../../../global/global_app_constants.dart';
import '../../../../global/widget_snackbar.dart';
import '../../conversation_constants.dart';
import '../../conversation_controller.dart';
import '../widget_person_one_feature_set_bottom/per1_ui_controller.dart';
import '../widget_rec_fedback_pulse_wave.dart';
import 'per2_ui_controller.dart';
import 'widget_per2_gender_selection_btn.dart';
import 'widget_per2_lang_selection_btn.dart';
import 'widget_per2_mic_icon_btn.dart';

class PersonTwoFeatureSetTop extends StatelessWidget {
  const PersonTwoFeatureSetTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Base Container with Mic Icon, Speaker, Copy buttons etc.
          Expanded(
            flex: 2,
            // Row with Mic icon and Circular Container with Copy Share etc/Recording Wave
            child: GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary),
                      child: GetBuilder<PersonTwoUIController>(builder: (personTwoController) {
                        // Stack so that a container on top to diable person two controls, if person one language is not set
                        return Stack(
                          children: [
                            personTwoController.isMicIconTappedDownAndHolding
                                ? const RecordingFeedbackPulseAndWave()
                                : Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          const PersonTwoMaleFemaleSwitch(),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        if (personTwoController.outputBoxText.isNotEmpty) {
                                                          FlutterClipboard.copy(personTwoController.outputBoxText).then((_) {
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
                                      const PersonTwoLanguageSelectionBtn(),
                                    ],
                                  ),
                            personTwoUIController.shallActivatePersonTwoControls
                                ? const SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary.withOpacity(0.8))),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(width: 10.h),
                  // Stack so that a container on top to diable person two Mic Icon, if person one language is not set
                  Stack(
                    children: [
                      const PersonTwoMicIconBtn(isSocketPreferred: isStreamingPreferred),
                      personTwoUIController.shallActivatePersonTwoControls && personTwoUIController.currentSelectedLanguageCode.isNotEmpty
                          ? const SizedBox()
                          : Container(
                              width: 0.15.sw,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w), color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
                            )
                    ],
                  )
                ],
              );
            }),
          ),

          SizedBox(height: 20.h),

          // Base Container where output will be shown
          GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
            ConversationController conversationController = Get.find();

            return Expanded(
              flex: 11,
              child: personTwoUIController.isAvaiableLanguageDialogOpen
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
                              'Choose their Language:',
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
                                itemCount: conversationController.avaiablePerTwoLangCodesTop.length,
                                itemBuilder: (context, index) {
                                  String eachTargetLanguage = conversationController.avaiablePerTwoLangCodesTop.elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      personTwoUIController.changeCurrentSelectedLanguageCode(currentSelectedLanguageCode: eachTargetLanguage);
                                      personTwoUIController.changeIsAvaiableLanguageDialogOpen(isAvaiableLanguageDialogOpen: false);
                                    },
                                    child: Center(
                                      child: AutoSizeText(
                                        GlobalAppConstants.getLanguageCodeOrName(value: eachTargetLanguage, returnWhat: LANGUAGE_MAP.languageName),
                                        minFontSize: (10.w).toInt().toDouble(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 25.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400),
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
                      padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 20.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.w),
                            bottomRight: Radius.circular(20.w),
                          ),
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
                      child: personTwoUIController.outputBoxText.isEmpty && Get.find<PersonOneUIController>().outputBoxText.isEmpty
                          ? AutoSizeText(
                              'This is their box. Ask their language and choose above. What they speak, will appear here after they stop speaking!',
                              minFontSize: (15.w).toInt().toDouble(),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 30.w, color: Theme.of(context).colorScheme.primary.withOpacity(0.2), fontWeight: FontWeight.w500),
                            )
                          : AutoSizeText(
                              personTwoUIController.outputBoxText.toString(),
                              minFontSize: (15.w).toInt().toDouble(),
                              maxLines: 16,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(fontSize: 27.w, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                            ),
                    ),
            );
          }),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
