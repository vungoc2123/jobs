import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.tabName});
  final String tabName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteD6,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child:Center(child: Text(tabName, style: AppTextStyle.textSm, textAlign: TextAlign.center,)),
    );
  }
}
