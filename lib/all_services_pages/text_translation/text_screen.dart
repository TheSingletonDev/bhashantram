import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhashantram/global/enum_global.dart';
import 'package:bhashantram/global/global_app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../global/widget_loading_screen.dart';
import '../widgets/model_services_page_header_container.dart';
import 'text_screen_controller.dart';

class TextNMTScreen extends StatelessWidget {
  const TextNMTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TextScreenController>().fetchULCAConfigForTextScreen();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(child: GetBuilder<TextScreenController>(builder: (textScreenControllerr) {
        return !textScreenControllerr.isULCAConfigLoaded
            ? const LoadingScreen(loadScreenTxt: 'Fetching languages for you!')
            : Column(
                children: [
                  // Page header with feature name and back button
                  ServicesPageHeaderContainer(
                    icon: Icon(Icons.text_fields_rounded, size: 70.w, color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)),
                    iconText: AutoSizeText(
                      'Text',
                      style: GoogleFonts.poppins(fontSize: 60.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // Remaining part other than page header with feature name and back button
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Stack(children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                          height: 0.5.sh,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                        ),
                        // Bottom Active Container
                        Positioned(
                            width: 1.sw,
                            bottom: 0,
                            child: Container(
                              height: 0.28.sh,
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(30.w),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                                child: GetBuilder<TextScreenController>(builder: (textScreenController) {
                                  return textScreenController.showLanguageSelectionPane
                                      // Source and Target Language Selection Pane
                                      ? const LanguageSelectionPaneWidget()
                                      // Typing and Share,Paste Icons etc/
                                      : const BottomTypingInputAndControlsWidget();
                                }),
                              ),
                            ))
                      ]),
                    ),
                  ),
                ],
              );
      })),
    );
  }
}

class LanguageSelectionPaneWidget extends StatelessWidget {
  const LanguageSelectionPaneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextScreenController textScreenController = Get.find();
    List<dynamic> languageList = textScreenController.isSourceLangPane ? textScreenController.availableSourceLanguages : textScreenController.correspondingTargetLangCodesList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child: AutoSizeText(
            'Choose your Language:',
            minFontSize: (15.w).toInt().toDouble(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 30.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GridView.builder(
              itemCount: languageList.length,
              itemBuilder: (context, index) {
                String eachLanguage = languageList.elementAt(index).toString();
                return InkWell(
                  onTap: () {
                    textScreenController.isSourceLangPane
                        ? () {
                            textScreenController.changeCurrentSelectedSourceLangCode(currentSelectedSourceLangCode: eachLanguage);
                            textScreenController.correspondingTargetLangCodeForSelectedSourceLangCode();
                          }()
                        : textScreenController.changeCurrentSelectedTargetLangCode(currentSelectedTargetLangCode: eachLanguage);

                    textScreenController.changeShowLanguageSelectionPane(showLanguageSelectionPane: false, isSourceLangPane: textScreenController.isSourceLangPane);
                  },
                  child: Center(
                    child: AutoSizeText(
                      GlobalAppConstants.getLanguageCodeOrName(value: eachLanguage, returnWhat: LANGUAGE_MAP.languageName),
                      minFontSize: (10.w).toInt().toDouble(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontSize: 22.w, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomTypingInputAndControlsWidget extends StatelessWidget {
  const BottomTypingInputAndControlsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextScreenController textScreenController = Get.find();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {
                  log('Language Btn Pressed: ${textScreenController.currentSelectedSourceLangCode}');
                  textScreenController.changeShowLanguageSelectionPane(showLanguageSelectionPane: true, isSourceLangPane: true);
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)),
                child: AutoSizeText(
                  GlobalAppConstants.getLanguageCodeOrName(value: textScreenController.currentSelectedSourceLangCode, returnWhat: LANGUAGE_MAP.languageName),
                  style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.compare_arrows_outlined,
              size: 30.w,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  log('Language Btn Pressed: ${textScreenController.currentSelectedTargetLangCode}');
                  textScreenController.changeShowLanguageSelectionPane(showLanguageSelectionPane: true, isSourceLangPane: false);
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)),
                child: AutoSizeText(
                  GlobalAppConstants.getLanguageCodeOrName(value: textScreenController.currentSelectedTargetLangCode, returnWhat: LANGUAGE_MAP.languageName),
                  style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(children: [
          Container(
            color: Colors.red,
            child: const Text(
              'Malayalam',
              textScaleFactor: 1.4,
            ),
          )
        ]),
        const Expanded(child: InputTextField()),
        SizedBox(
          width: 1.sw,
          height: 50.h,
          child: FilledButton(
            onPressed: () {
              log('Translate Btn Pressed');
            },
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)),
            child: AutoSizeText(
              'Translate',
              style: GoogleFonts.poppins(fontSize: 20.w, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 4,
      maxLength: 500,
      onChanged: (value) {
        print(value);
        if (value.endsWith(' ')) {
          print('now');
        }
      },
      onTapOutside: (event) {
        _focusNode.unfocus();
      },
      style: TextStyle(fontSize: 22.w, color: Theme.of(context).colorScheme.onPrimary, decorationColor: Theme.of(context).colorScheme.onPrimary),
      cursorColor: Theme.of(context).colorScheme.onPrimary,
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Tap Here and Start Typing...',
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7), fontSize: 30.w, fontWeight: FontWeight.w600),
        border: InputBorder.none,
        counterText: '',
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
