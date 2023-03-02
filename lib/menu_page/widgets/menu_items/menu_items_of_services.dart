import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model_menu_item_container.dart';

class MenuItemServices extends StatelessWidget {
  const MenuItemServices({
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
                      icon: Icon(Icons.settings_voice_outlined, size: 65.w, color: Theme.of(context).colorScheme.onPrimary),
                      text: AutoSizeText('Voice',
                          style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.text_fields_rounded, size: 70.w, color: Theme.of(context).colorScheme.onPrimary),
                      text: AutoSizeText('Text',
                          style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.social_distance_outlined, size: 70.w, color: Theme.of(context).colorScheme.onPrimary),
                      text: AutoSizeText('Converse',
                          style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400)))),
            ],
          ),
        ),

        // Row 2 of Menu Items for Services tab
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.edit_document, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Document',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.fit_screen_sharp, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Scan',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
              Expanded(
                  child: MenuItemContainerModel(
                      icon: Icon(Icons.video_camera_back_outlined, size: 70.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                      text: AutoSizeText('Video',
                          style: GoogleFonts.poppins(
                              fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3), fontWeight: FontWeight.w400)))),
            ],
          ),
        ),
      ],
    );
  }
}
