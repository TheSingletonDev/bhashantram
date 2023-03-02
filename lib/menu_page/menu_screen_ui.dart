import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/menu_carousel/menu_carousel.dart';
import 'widgets/menu_items/menu_items.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              // Top Container with Settings Btn, Language Selection Btn and Menu Description Scrollable items
              Expanded(
                flex: 13,
                child: Container(
                  width: 100.sw,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.w), bottomLeft: Radius.circular(50.w))),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

                  // Base Container and Connected Dots Stack
                  child: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: Get.isDarkMode
                            ? const ColorFilter.matrix([-1, 0, 0, 0, 255, 0, -1, 0, 0, 255, 0, 0, -1, 0, 255, 0, 0, 0, 0.3, 0])
                            : const ColorFilter.matrix([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.2, 0]),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/connected_dots_top_right.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Settings Icon, Language Selection Button and Menu Carousel at top describing each feature
                      Column(
                        children: [
                          // Settings Icon and Language Selection Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Settings Icon Button
                              IconButton(
                                onPressed: () {
                                  print('Settings Icon pressed');
                                },
                                icon: Icon(
                                  Icons.settings_rounded,
                                  size: 40.w,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),

                              // App Language Selection Button
                              Container(
                                padding: EdgeInsets.only(right: 10.w),
                                height: 50.h,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    print('Language Icon pressed');
                                  },
                                  icon: const Icon(Icons.language),
                                  label: AutoSizeText(
                                    'English',
                                    style: GoogleFonts.poppins(
                                        fontSize: 17.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),

                          // Menu Carousel at top describing each feature present in the bottom half of the screen (menu_items folder)
                          const MenuCarousel(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              // Service/Contribution Buttons and Menu Items in the bottom half of the screen
              const MenuItems(),

              // Bottom bar 'Developed with ❤'
              Expanded(
                flex: 1,
                child: Container(
                  width: 100.sw,
                  color: Get.isDarkMode ? Colors.grey.shade800.withAlpha(100) : Colors.grey.shade300,
                  child: Center(
                    child: AutoSizeText.rich(
                      TextSpan(
                        text: 'Developed with ❤ by EkStep Foundation',
                        style: GoogleFonts.kodchasan(
                            fontSize: 13.w,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                            wordSpacing: 2.w,
                            letterSpacing: 1.w),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
