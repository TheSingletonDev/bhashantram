import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../global/widget_snackbar.dart';
import 'conversation_screen_controller.dart';

class PersonTwoFeatureSetBottom extends StatelessWidget {
  const PersonTwoFeatureSetBottom({
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
                    bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w),
                  ),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            ),
          ),
          SizedBox(height: 20.h),
          // Base Container with Speaker, Copy buttons etc.
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(200.w), color: Theme.of(context).colorScheme.primary))),
                SizedBox(width: 10.h),
                // Added this builder method just so we can have tapStartTime and tapDuration variables here itself
                Builder(builder: (context) {
                  DateTime? tapStartTime;
                  Duration? tapDuration;
                  return GestureDetector(
                    // This wont work to detect if it was just a tap or tap and hold coz implicitly once tap up is hit, onTap completes too.
                    // onTap: () => showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context),
                    onTapDown: (details) {
                      AudioPlayer().play(AssetSource('audio/beep.mp3'));
                      tapStartTime = DateTime.now();
                      ConversationScreenController conversationScreenController = Get.find();
                      conversationScreenController.changeIsMicIconTappedDown(
                          isMicIconTappedDownAndHolding: !conversationScreenController.isMicIconTappedDownAndHolding);
                    },
                    onTapUp: (_) {
                      if (tapStartTime != null) {
                        tapDuration = DateTime.now().difference(tapStartTime!);
                        if (tapDuration! < const Duration(milliseconds: 600)) {
                          showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context);
                        }
                        tapStartTime = null;
                      }
                      ConversationScreenController conversationScreenController = Get.find();
                      conversationScreenController.changeIsMicIconTappedDown(
                          isMicIconTappedDownAndHolding: !conversationScreenController.isMicIconTappedDownAndHolding);
                    },
                    onTapCancel: () {
                      ConversationScreenController conversationScreenController = Get.find();
                      conversationScreenController.changeIsMicIconTappedDown(
                          isMicIconTappedDownAndHolding: !conversationScreenController.isMicIconTappedDownAndHolding);
                    },
                    onPanEnd: (_) {
                      ConversationScreenController conversationScreenController = Get.find();
                      // If condition to check that things execute only when button is tapped down.
                      /**Without If condition:
                         * User taps and hold the button, value becomes true,
                         * User pans slightly, things execute value becomes false, mic gets released
                         * Now if pan continues (which usually does), this will execute again and will make value true which will make mic to be pressed again
                         */
                      if (conversationScreenController.isMicIconTappedDownAndHolding) {
                        conversationScreenController.changeIsMicIconTappedDown(
                            isMicIconTappedDownAndHolding: !conversationScreenController.isMicIconTappedDownAndHolding);
                      }
                    },
                    child: GetBuilder<ConversationScreenController>(builder: (conversationScreenController) {
                      return Container(
                        width: 0.15.sw,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: conversationScreenController.isMicIconTappedDownAndHolding
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                                : Theme.of(context).colorScheme.primary),
                        child: Icon(Icons.mic_none_rounded,
                            size: conversationScreenController.isMicIconTappedDownAndHolding ? 60.w : 40.w,
                            color: Theme.of(context).colorScheme.onPrimary),
                      );
                    }),
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
