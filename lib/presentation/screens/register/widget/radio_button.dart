import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/gender.dart';

class RadioButton extends StatelessWidget {
  const RadioButton(
      {super.key,
      required this.values,
      required this.title,
      this.callback,
      required this.defaultValue});

  final String title;
  final Gender values;
  final Gender defaultValue;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback?.call(),
      borderRadius: BorderRadius.circular(16.w),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            values == defaultValue
                ? Icon(
                    Icons.check_circle,
                    size: 20.r,
                    color: AppColors.blue,
                  )
                : Icon(
                    Icons.circle_outlined,
                    size: 20.r,
                    color: AppColors.blue,
                  ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              title,
              style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
            )
          ],
        ),
      ),
    );
  }
}
