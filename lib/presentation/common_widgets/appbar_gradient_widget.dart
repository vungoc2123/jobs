import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class GradientAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final VoidCallback? leadingAction;
  final List<Widget>? actions;
  final List<VoidCallback>? actionFunction;
  final double? barHeight;

  const GradientAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.leadingAction,
    this.actionFunction,
    this.barHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + (barHeight ?? 50.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.blue44, AppColors.blueF8],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(alignment: Alignment.center, children: [
        if (leading != null)
          Positioned(
              left: 0,
              child: IconButton(
                  onPressed: () {
                    leadingAction!.call();
                  },
                  icon: leading!)),
        if (title != null)
          Align(
            alignment: Alignment.center,
            child:
                Text(title!, style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        if (actions != null)
          Positioned(
            right: 10.w,
            child: Row(
              children: List.generate(
                  actions!.length, (index) => Padding(padding: EdgeInsets.only(left: 10.w), child: actions![index])),
            ),
          )
      ]),
    );
  }
}
