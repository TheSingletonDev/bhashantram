import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhashantram/all_services_pages/conversation/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/model_services_page_header_container.dart';
import 'widgets/widget_person_one_feature_set_bottom/pers1_feature_set_bottom.dart';
import 'widgets/widget_person_two_feature_set_top/per2_feature_set_top.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ConversationController conversationController = Get.find();
    conversationController.fetchULCAConfig();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(child: GetBuilder<ConversationController>(builder: (conversationController) {
        return !conversationController.isULCAConfigLoaded
            ? const LoadingScreen()
            : Column(
                children: [
                  // Page header with feature name and back button
                  ServicesPageHeaderContainer(
                    icon: Icon(Icons.social_distance_outlined, size: 60.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
                    iconText: AutoSizeText(
                      'Converse',
                      style:
                          GoogleFonts.poppins(fontSize: 60.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
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
                          Container(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), height: 1.h, width: 0.7.sw),
                          SizedBox(height: 20.h),
                          // Bottom Base Container that contains Output Container and Container with Copy, Share Buttons etc.
                          const Expanded(
                            child: PersonOneFeatureSetBottom(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
      })),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitSpinningLines(color: Theme.of(context).colorScheme.onPrimary, size: 0.5.sw),
            30.verticalSpace,
            AutoSizeText.rich(
              TextSpan(
                  text: 'Fetching Languages for you!',
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 25.w,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
