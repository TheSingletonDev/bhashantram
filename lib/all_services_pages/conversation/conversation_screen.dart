import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/model_services_page_header_container.dart';
import 'widgets/widget_person_one_feature_set_bottom/person_one_feature_set_bottom.dart';
import 'widgets/widget_person_one_feature_set_bottom/person_one_feature_set_bottom.dart';
import 'widgets/widget_person_two_feature_set_top/person_two_feature_set_top.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
          child: Column(
        children: [
          // Page header with feature name and back button
          ServicesPageHeaderContainer(
            icon: Icon(Icons.social_distance_outlined, size: 50.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
            iconText: AutoSizeText(
              'Converse',
              style: GoogleFonts.poppins(fontSize: 60.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
            ),
          ),
          // Remaining part other than page header with feature name and back button
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              // Contains both Top and Bottom Containers of each person
              child: Column(
                children: [
                  SizedBox(height: 20.w),
                  // Top Base Container that contains Output Container and Container with Copy, Share Buttons etc.
                  const Expanded(
                    child: PersonTwoFeatureSetTop(),
                  ),
                  SizedBox(height: 50.h),
                  // Bottom Base Container that contains Output Container and Container with Copy, Share Buttons etc.
                  const Expanded(
                    child: PersonOneFeatureSetBottom(),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
