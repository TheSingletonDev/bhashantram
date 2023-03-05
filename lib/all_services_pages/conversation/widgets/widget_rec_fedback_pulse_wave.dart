import 'dart:math';

import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecordingFeedbackPulseAndWave extends StatelessWidget {
  const RecordingFeedbackPulseAndWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        SpinKitPulse(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 50.w,
        ),
        SizedBox(width: 10.w),
        AudioWave(
            height: 50.h,
            width: 0.59.sw,
            spacing: 3,
            bars: List.generate(60, (index) {
              return AudioWaveBar(
                heightFactor: Random().nextDouble(),
                color: Theme.of(context).colorScheme.onPrimary,
              );
            }))
      ],
    );
  }
}
