import 'package:flutter/material.dart';

class AppSlideTab extends StatelessWidget {
  final List<Widget> tabBars;
  final List<Widget> tabBarViews;
  final BoxDecoration? boxDecoration;
  final Color? background;
  final Color? indicatorColor;
  final Color unselectedLabelColor;
  final Color labelColor;
  final double radius;
  final double divider;
  final bool isExpandIndicator;
  final EdgeInsets? padding;
  final double space;
  final BoxDecoration? boxDecorationOutSide;
  final double? paddingOutSide;

  const AppSlideTab(
      {super.key,
      required this.tabBars,
      required this.tabBarViews,
      this.boxDecoration,
      this.background = Colors.white,
      this.indicatorColor,
      this.unselectedLabelColor = Colors.black,
      this.labelColor = Colors.lightBlue,
      this.radius = 0,
      this.divider = 1,
      this.space = 4,
      this.padding,
      this.isExpandIndicator = false,
      this.boxDecorationOutSide,
      this.paddingOutSide});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBars.length,
      child: Column(
        children: [
          Container(
            padding: paddingOutSide != null
                ? EdgeInsets.all(paddingOutSide!)
                : const EdgeInsets.all(0),
            decoration: boxDecoration != null ? boxDecorationOutSide : null,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: background),
              child: TabBar(
                  dividerHeight: divider,
                  indicatorSize: isExpandIndicator == true
                      ? TabBarIndicatorSize.tab
                      : null,
                  indicator: boxDecoration,
                  labelColor: labelColor,
                  unselectedLabelColor: unselectedLabelColor,
                  splashBorderRadius: BorderRadius.circular(radius),
                  tabs: tabBars),
            ),
          ),
          SizedBox(
            height: space,
          ),
          Expanded(
              child: TabBarView(
            children: tabBarViews,
          ))
        ],
      ),
    );
  }
}
