import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';

class AppSlideWidget extends StatefulWidget {
  final List<Widget> widgets;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final bool showIndicator;
  final double sizeIndicator;
  final double aspectRatio;
  final Color selectedColor;
  final Color unselectedColor;
  final bool isExpandIndicator;
  final double space;
  final double viewportFraction;
  final double? height;
  final bool enableInfiniteScroll;

  const AppSlideWidget(
      {super.key,
      required this.widgets,
      this.enableInfiniteScroll = false,
      this.autoPlay = true,
      this.enlargeCenterPage = true,
      this.aspectRatio = 2,
      this.space = -30,
      this.viewportFraction = 1,
      this.showIndicator = true,
      this.sizeIndicator = 8,
      this.height,
      this.selectedColor = AppColors.blue,
      this.unselectedColor = AppColors.grey,
      this.isExpandIndicator = true});

  @override
  State<AppSlideWidget> createState() => _AppSlideWidgetState();
}

class _AppSlideWidgetState extends State<AppSlideWidget> {
  late ValueNotifier<int> _current;
  late final CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _current = ValueNotifier<int>(0);
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _current,
      builder: (BuildContext context, value, Widget? child) {
        return Stack(clipBehavior: Clip.none, children: [
          CarouselSlider(
            items: widget.widgets,
            carouselController: _controller,
            options: CarouselOptions(
                enableInfiniteScroll: widget.enableInfiniteScroll,
                height: widget.height,
                viewportFraction: widget.viewportFraction,
                autoPlay: widget.autoPlay,
                enlargeCenterPage: widget.enlargeCenterPage,
                aspectRatio: widget.aspectRatio,
                onPageChanged: (index, reason) {
                  _current.value = index;
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: widget.space,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.widgets.asMap().entries.map((entry) {
                return Container(
                  width: _current.value == entry.key
                      ? widget.sizeIndicator *
                          (widget.isExpandIndicator == true ? 2 : 1)
                      : widget.sizeIndicator,
                  height: widget.sizeIndicator,
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: _current.value == entry.key
                          ? widget.selectedColor
                          : widget.unselectedColor),
                );
              }).toList(),
            ),
          ),
        ]);
      },
    );
  }
}
