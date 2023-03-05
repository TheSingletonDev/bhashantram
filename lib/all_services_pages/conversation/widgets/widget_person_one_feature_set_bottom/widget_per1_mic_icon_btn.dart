import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../global/widget_snackbar.dart';
import 'per1_ui_controller.dart';

class PersonOneMicIconBtn extends StatelessWidget {
  const PersonOneMicIconBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      DateTime? tapStartTime;
      Duration? tapDuration;

      return GetBuilder<PersonOneUIController>(builder: (personOneController) {
        return personOneController.currentSelectedLanguageCode.isEmpty
            ? GestureDetector(
                // onTap: () => showSnackbar(title: 'Error', message: 'Select a language first!', context: context),
                onTapDown: (details) => showSnackbar(title: 'Error', message: 'Select a language first!', context: context),
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
                  personOneController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personOneController.isMicIconTappedDownAndHolding);

                  // Close the language selection Container, if mic icon press is started
                  if (personOneController.isAvaiableLanguageDialogOpen) {
                    personOneController.changeIsAvaiableLanguageDialogOpen(
                        isAvaiableLanguageDialogOpen: !personOneController.isAvaiableLanguageDialogOpen);
                  }
                },
                onTapUp: (_) {
                  if (tapStartTime != null) {
                    tapDuration = DateTime.now().difference(tapStartTime!);
                    if (tapDuration! < const Duration(milliseconds: 600)) {
                      showSnackbar(title: 'Error', message: 'Tap and hold to record!', context: context);
                    }
                    tapStartTime = null;
                  }
                  personOneController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personOneController.isMicIconTappedDownAndHolding);
                },
                onTapCancel: () {
                  personOneController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personOneController.isMicIconTappedDownAndHolding);
                },
                onPanEnd: (_) {
                  // If condition to check that things execute only when button is tapped down.
                  /**Without If condition:
                 * User taps and hold the button, value becomes true,
                 * User pans slightly, things execute value becomes false, mic gets released
                 * Now if pan continues (which usually does), this will execute again and will make value true which will make mic to be pressed again
                 */
                  if (personOneController.isMicIconTappedDownAndHolding) {
                    personOneController.changeIsMicIconTappedDown(isMicIconTappedDownAndHolding: !personOneController.isMicIconTappedDownAndHolding);
                  }
                },
                child: Container(
                  width: 0.15.sw,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: personOneController.isMicIconTappedDownAndHolding
                          ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                          : Theme.of(context).colorScheme.primary),
                  child: Icon(Icons.mic_none_rounded,
                      size: personOneController.isMicIconTappedDownAndHolding ? 60.w : 40.w, color: Theme.of(context).colorScheme.onPrimary),
                ));
      });
    });
  }
}
