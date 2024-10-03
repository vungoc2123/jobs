import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isCenter;
  final Color? textColor;
  const RowWidget({super.key,required this.title,required this.iconPath,this.isCenter=false,this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20.r,
          height: 20.r,
          colorFilter: const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          title,
          style: textColor == null
              ? AppTextStyle.textBase
              : AppTextStyle.textBase.copyWith(color: textColor),
        )
      ],
    );
  }
}
