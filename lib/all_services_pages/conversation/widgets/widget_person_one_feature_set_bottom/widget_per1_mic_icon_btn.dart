import 'package:audioplayers/audioplayers.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_recorder_api_controller.dart';
import 'package:bhashantram/all_services_pages/conversation/widgets/widget_person_one_feature_set_bottom/per1_recorder_socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../../../../global/widget_snackbar.dart';
import '../widget_person_two_feature_set_top/per2_ui_controller.dart';
import 'per1_ui_controller.dart';

class PersonOneMicIconBtn extends StatelessWidget {
  final bool isSocketPreferred;
  const PersonOneMicIconBtn({
    super.key,
    required this.isSocketPreferred,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      DateTime? tapStartTime;
      Duration? tapDuration;

      PersonOneAPIRecorderController personOneAPIRecorderController = Get.find();

      return GetBuilder<PersonOneUIController>(builder: (personOneUIController) {
        String errorTextMsg = personOneUIController.currentSelectedLanguageCode.isEmpty
            ? 'Select your language at the bottom!'
            : 'Select the language they speak at the top!';

        return GetBuilder<PersonTwoUIController>(builder: (personTwoUIController) {
          return personOneUIController.currentSelectedLanguageCode.isEmpty || personTwoUIController.currentSelectedLanguageCode.isEmpty
              ? GestureDetector(
                  onTapDown: (details) => showSnackbar(title: 'Error', message: errorTextMsg, context: context),
                  child: Container(
                    width: 0.15.sw,
                    height: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Theme.of(context).colorScheme.primary),
                    child: Icon(Icons.mic_none_rounded, size: 40.w, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                )
              : GestureDetector(
                  // This wont work to detect if it was just a tap or tap and hold coz implicitly once tap up is hit, onTap completes too.
                  // onTap: () => showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context),
                  onTapDown: (_) {
                    AudioPlayer().play(AssetSource('audio/beep.mp3'));
                    tapStartTime = DateTime.now();
                    personOneUIController.changeIsMicIconTappedDown(
                        isMicIconTappedDownAndHolding: !personOneUIController.isMicIconTappedDownAndHolding);

                    // Close the language selection Container, if mic icon press is started
                    if (personOneUIController.isAvaiableLanguageDialogOpen) {
                      personOneUIController.changeIsAvaiableLanguageDialogOpen(
                          isAvaiableLanguageDialogOpen: !personOneUIController.isAvaiableLanguageDialogOpen);
                    }
                    isSocketPreferred
                        ? Get.find<PersonOneSocketRecorderController>().recordVoice()
                        : personOneAPIRecorderController.startPerOneVoiceRecording();
                  },
                  onTapUp: (_) {
                    if (tapStartTime != null) {
                      tapDuration = DateTime.now().difference(tapStartTime!);
                      if (tapDuration! < const Duration(milliseconds: 600)) {
                        showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context);
                      }
                      tapStartTime = null;
                    }
                    personOneUIController.changeIsMicIconTappedDown(
                        isMicIconTappedDownAndHolding: !personOneUIController.isMicIconTappedDownAndHolding);
                    isSocketPreferred
                        ? Get.find<PersonOneSocketRecorderController>().stopRecording()
                        : personOneAPIRecorderController.stopPerOneRecording();
                  },
                  onTapCancel: () {
                    personOneUIController.changeIsMicIconTappedDown(
                        isMicIconTappedDownAndHolding: !personOneUIController.isMicIconTappedDownAndHolding);
                    isSocketPreferred
                        ? Get.find<PersonOneSocketRecorderController>().stopRecording()
                        : personOneAPIRecorderController.stopPerOneRecording();
                  },
                  onPanEnd: (_) {
                    // If condition to check that things execute only when button is tapped down.
                    /**Without If condition:
                     * User taps and hold the button, value becomes true,
                     * User pans slightly, things execute value becomes false, mic gets released
                     * Now if pan continues (which usually does), this will execute again and will make value true which will make mic to be pressed again
                     */
                    if (personOneUIController.isMicIconTappedDownAndHolding) {
                      personOneUIController.changeIsMicIconTappedDown(
                          isMicIconTappedDownAndHolding: !personOneUIController.isMicIconTappedDownAndHolding);
                      isSocketPreferred
                          ? Get.find<PersonOneSocketRecorderController>().stopRecording()
                          : personOneAPIRecorderController.stopPerOneRecording();
                    }
                  },
                  child: Container(
                    width: 0.15.sw,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                        color: personOneUIController.isMicIconTappedDownAndHolding
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                            : Theme.of(context).colorScheme.primary),
                    child: Icon(Icons.mic_none_rounded,
                        size: personOneUIController.isMicIconTappedDownAndHolding ? 60.w : 40.w, color: Theme.of(context).colorScheme.onPrimary),
                  ));
        });
      });
    });
  }
}
