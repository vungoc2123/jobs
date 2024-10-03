import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class AppNotEmptyListWidget extends StatelessWidget {
  final Widget icon;
  final String title;

  const AppNotEmptyListWidget(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          height: 12.h,
        ),
        Text(
          title,
          style: AppTextStyle.textSm
              .copyWith(fontWeight: FontWeight.w500, color: AppColors.grey),
        )
      ],
    );
  }
}
