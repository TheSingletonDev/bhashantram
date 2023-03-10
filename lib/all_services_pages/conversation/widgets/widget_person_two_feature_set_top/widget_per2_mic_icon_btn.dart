import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../../global/widget_snackbar.dart';
import 'per2_recorder_controller.dart';
import 'per2_ui_controller.dart';

class PersonTwoMicIconBtn extends StatelessWidget {
  const PersonTwoMicIconBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      DateTime? tapStartTime;
      Duration? tapDuration;

      PersonTwoUIController personTwoController = Get.find();
      PersonTwoRecorderController personTwoRecorderController = Get.find();

      return GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
        return GestureDetector(
          // This wont work to detect if it was just a tap or tap and hold coz implicitly once tap up is hit, onTap completes too.
          // onTap: () => showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context),
          onTapDown: (_) {
            AudioPlayer().play(AssetSource('audio/beep.mp3'));
            tapStartTime = DateTime.now();

            personTwoController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personTwoController.isMicIconTappedDownAndHolding);
            // Close the language selection Container, if mic icon press is started
            if (personTwoUIController.isAvaiableLanguageDialogOpen) {
              personTwoUIController.changeIsAvaiableLanguageDialogOpen(
                  isAvaiableLanguageDialogOpen: !personTwoUIController.isAvaiableLanguageDialogOpen);
            }
            personTwoRecorderController.startPerTwoVoiceRecording();
          },
          onTapUp: (_) {
            if (tapStartTime != null) {
              tapDuration = DateTime.now().difference(tapStartTime!);
              if (tapDuration! < const Duration(milliseconds: 600)) {
                showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context);
              }
              tapStartTime = null;
            }
            personTwoController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personTwoController.isMicIconTappedDownAndHolding);
            personTwoRecorderController.stopPerTwoRecording();
          },
          onTapCancel: () {
            personTwoController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personTwoController.isMicIconTappedDownAndHolding);
            personTwoRecorderController.stopPerTwoRecording();
          },
          onPanEnd: (_) {
            // If condition to check that things execute only when button is tapped down.
            /**Without If condition:
                 * User taps and hold the button, value becomes true,
                 * User pans slightly, things execute value becomes false, mic gets released
                 * Now if pan continues (which usually does), this will execute again and will make value true which will make mic to be pressed again
                 */
            if (personTwoController.isMicIconTappedDownAndHolding) {
              personTwoController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personTwoController.isMicIconTappedDownAndHolding);
              personTwoRecorderController.stopPerTwoRecording();
            }
          },
          child: GetBuilder<PersonTwoUIController>(builder: (personTwoController) {
            return Container(
              width: 0.15.sw,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: personTwoController.isMicIconTappedDownAndHolding
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                      : Theme.of(context).colorScheme.primary),
              child: Icon(Icons.mic_none_rounded,
                  size: personTwoController.isMicIconTappedDownAndHolding ? 60.w : 40.w, color: Theme.of(context).colorScheme.onPrimary),
            );
          }),
        );
      });
    });
  }
}
