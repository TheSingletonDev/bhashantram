import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'person_one_controller.dart';
import '../widget_rec_fedback_pulse_wave.dart';
import 'widget_person_one_gender_selection_btn.dart';
import 'widget_person_one_lang_selection_btn.dart';
import 'widget_person_one_mic_icon_btn.dart';

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
          // Base Container where output will be shown
          Expanded(
            flex: 11,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            ),
          ),
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
                    child: GetBuilder<PersonOneController>(builder: (personOneController) {
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
                                const PersonOneLanguageSelectionBtn(),
                              ],
                            );
                    }),
                  ),
                ),
                SizedBox(width: 10.h),
                // Added this builder method just so we can have tapStartTime and tapDuration variables here itself
                // Mic Icon
                const PersonOneMicIconBtn()
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
