import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model_menu_carousel_page.dart';
import 'widget_menu_desc_carousel.dart';

class MenuServicesCarousel extends StatelessWidget {
  const MenuServicesCarousel({super.key});

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
                    text: 'I am Bhashaverse',
                    style: GoogleFonts.poppins(
                      fontSize: 39.w,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w400,
                    ))
              ])),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'What should I translate for you today?',
              style: GoogleFonts.poppins(fontSize: 43.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500))),
        ),

        // Menu Carousel Page 2
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.microphone, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.volume_up_rounded, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Voice',
              style: GoogleFonts.poppins(
                fontSize: 75.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Translate your voice from one language to another!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 3
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.penToSquare, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.text_fields_rounded, size: 100.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Text',
              style: GoogleFonts.poppins(
                fontSize: 75.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Translate your Text from one language to another!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 4
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.walkieTalkie, size: 75.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.social_distance_outlined, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          iconText: AutoSizeText.rich(TextSpan(
              text: 'Converse',
              style: GoogleFonts.poppins(
                fontSize: 70.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Talk to someone who does not know the language you speak!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 5
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.fileInvoice, size: 70.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.edit_document, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),

          iconText: AutoSizeText.rich(TextSpan(
              text: 'Document',
              style: GoogleFonts.poppins(
                fontSize: 65.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Translate & Read all Documents in your language!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 6
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.camera, size: 70.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.fit_screen_rounded, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),

          iconText: AutoSizeText.rich(TextSpan(
              text: 'Scan',
              style: GoogleFonts.poppins(
                fontSize: 75.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Point your camera and read in the language you know!',
              style: GoogleFonts.poppins(fontSize: 39.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),

        // Menu Carousel Page 7
        MenuCarouselPageModel(
          // icon: FaIcon(FontAwesomeIcons.video, size: 70.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
          icon: Icon(Icons.video_camera_back_rounded, size: 80.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),

          iconText: AutoSizeText.rich(TextSpan(
              text: 'Video',
              style: GoogleFonts.poppins(
                fontSize: 75.w,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ))),
          pureText: AutoSizeText.rich(TextSpan(
              text: 'Replay your videos with Transcriptions and Translatations on the go!',
              style: GoogleFonts.poppins(fontSize: 38.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w400))),
        ),
      ]),
    );
  }
}
