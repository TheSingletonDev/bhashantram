import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_two_feature_set_top/person_two_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget_rec_fedback_pulse_wave.dart';
import 'widget_person_two_gender_selection_btn.dart';
import 'widget_person_two_lang_selection_btn.dart';
import 'widget_person_two_mic_icon_btn.dart';

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
          // SizedBox(height: 20.h),

          // Base Container with Mic Icon, Speaker, Copy buttons etc.
          Expanded(
            flex: 2,
            // Row with Mic icon and Circular Container with Copy Share etc/Recording Wave
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary),
                    child: GetBuilder<PersonTwoController>(builder: (personTwoController) {
                      return personTwoController.isMicIconTappedDownAndHolding
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
                                                  print('Copied');
                                                },
                                                highlightColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                                                icon: Icon(
                                                  Icons.copy_rounded,
                                                  color: Theme.of(context).colorScheme.onPrimary,
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
                            );
                    }),
                  ),
                ),
                SizedBox(width: 10.h),
                // Added this builder method just so we can have tapStartTime and tapDuration variables here itself
                // Mic Icon
                const PersonTwoMicIconBtn()
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // Base Container where output will be shown
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w),
                  ),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
