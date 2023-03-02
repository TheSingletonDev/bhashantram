import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model_menu_carousel_page.dart';
import 'widget_menu_desc_carousel.dart';

class MenuContributeCarousel extends StatelessWidget {
  const MenuContributeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MenuItemDescCarousal(listOfPages: [
        // Menu Carousel Page 1
        MenuCarouselPageModel(
          icon: Icon(Icons.home_rounded, size: 100.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Hello,\n',
              style: GoogleFonts.poppins(fontSize: 30.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
              children: [
                TextSpan(
                    text: 'I am BhashaDaan',
                    style: GoogleFonts.poppins(
                      fontSize: 39.w,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w400,
                    ))
              ])),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'How would you like to make some contributions today?',
              style: GoogleFonts.poppins(fontSize: 43.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500))),
        ),

        // Menu Carousel Page 2
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.microphone, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.hearing_rounded, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Suno India',
              style: GoogleFonts.poppins(
                fontSize: 63.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Contribute by typing listening to an audio and typing the text!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 3
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.walkieTalkie, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.settings_voice_rounded, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Bolo India',
              style: GoogleFonts.poppins(
                fontSize: 63.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Contributing your voice by reading aloud the text shown!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 4
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.penToSquare, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.keyboard_rounded, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Likho India',
              style: GoogleFonts.poppins(
                fontSize: 63.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Contribute by typing the translated text of the text shown!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 5
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.fileInvoice, size: 70.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.image_aspect_ratio_rounded, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),

          iconText: AutoSizeText.rich(TextSpan(
              text: 'Dekho India',
              style: GoogleFonts.poppins(
                fontSize: 63.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Contribute by typing the same text which is shown in the images!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),
      ]),
    );
  }
}
