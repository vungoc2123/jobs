import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class CustomTabBarWidget extends StatefulWidget {
  final List<String> tabTitles;
  final List<Widget> tabWidgets;

  const CustomTabBarWidget(
      {super.key, required this.tabTitles, required this.tabWidgets});

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget> {
  late ValueNotifier<int> currentIndex;

  double changePositionOfLine(double parentWidth) {
    for (var i = 0; i < widget.tabTitles.length; i++) {
      if (currentIndex.value == i) {
        return parentWidth / widget.tabTitles.length * i;
      }
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;

        return ValueListenableBuilder(
            valueListenable: currentIndex,
            builder: (_, value, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: SizedBox(
                              width: parentWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                    widget.tabTitles.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            currentIndex.value = index;
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: parentWidth /
                                                  widget.tabTitles.length,
                                              padding: EdgeInsets.all(10.r),
                                              child: Text(
                                                widget.tabTitles[index],
                                                style:
                                                    AppTextStyle.textSm.copyWith(
                                                        color: currentIndex
                                                                    .value ==
                                                                index
                                                            ? AppColors.blueEA
                                                            : AppColors.grey,
                                                        fontWeight: currentIndex
                                                                    .value ==
                                                                index
                                                            ? FontWeight.bold
                                                            : FontWeight.w300,
                                                        fontSize: currentIndex
                                                                    .value ==
                                                                index
                                                            ? 14.sp
                                                            : 12.sp),
                                              )),
                                        )),
                              )),
                        ),
                        AnimatedPositioned(
                          bottom: 0,
                          left: changePositionOfLine(parentWidth),
                          duration: const Duration(milliseconds: 300),
                          child: AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2000),
                            width: parentWidth / widget.tabTitles.length,
                            height: 2.r,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.tabWidgets[currentIndex.value]
                ],
              );
            });
      },
    );
  }
}
