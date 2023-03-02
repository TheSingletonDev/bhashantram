import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemDescCarousal extends StatefulWidget {
  final List<Widget> listOfPages;

  const MenuItemDescCarousal({super.key, required this.listOfPages});
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MenuItemDescCarousal> {
  int _current = 0;
  bool _autoPlay = true;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: widget.listOfPages,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: _autoPlay,
              viewportFraction: 1,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 5 / 3, // Connected to parent padding
              autoPlayInterval: const Duration(seconds: 13),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });

                if (reason == CarouselPageChangedReason.manual) {
                  setState(() {
                    _autoPlay = false;
                  });
                }
              }),
        ),
      ),
      SizedBox(height: 10.w),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.listOfPages.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: _current == entry.key ? 16.w : 14.w,
              height: _current == entry.key ? 16.w : 14.w,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _current == entry.key ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary),
                  color: Theme.of(context).colorScheme.primary.withOpacity(_current == entry.key ? 1 : 0.0)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
