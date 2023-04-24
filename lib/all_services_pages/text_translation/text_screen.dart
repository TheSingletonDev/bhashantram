import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/model_services_page_header_container.dart';

class TextNMTScreen extends StatelessWidget {
  const TextNMTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
          child: Column(
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
                      child: Column(
                        children: [
                          InputTextField(),
                        ],
                      ),
                    ))
              ]),
            ),
          ),
        ],
      )),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: TextField(
        maxLines: 2,
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
        style: TextStyle(fontSize: 25.w, color: Theme.of(context).colorScheme.onPrimary, decorationColor: Theme.of(context).colorScheme.onPrimary),
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Tap Here and Start Typing...',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7), fontSize: 30.w, fontWeight: FontWeight.w600),
          border: InputBorder.none,
          counterText: '',
        ),
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
