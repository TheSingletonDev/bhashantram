import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model_menu_item_container.dart';

class MenuItemContribute extends StatelessWidget {
  const MenuItemContribute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row 1 of Menu Items for Services tab
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.hearing_rounded, size: 65.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Suno India',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.settings_voice_rounded, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Bolo India',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
            ],
          ),
        ),

        // Row 2 of Menu Items for Services tab
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.keyboard_rounded, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Likho India',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.image_aspect_ratio_rounded, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Dekho India',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
            ],
          ),
        ),
      ],
    );
  }
}
