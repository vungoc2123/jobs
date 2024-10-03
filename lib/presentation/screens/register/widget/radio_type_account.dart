import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';

import '../../../../application/constants/app_color.dart';
import '../../../../application/constants/app_text_style.dart';

class RadioTypeAccount extends StatelessWidget {
  const RadioTypeAccount(
      {super.key,
      this.callback,
      required this.filterResponse,
      required this.value});

  final FilterResponse filterResponse;
  final String value;
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
            filterResponse.value == value
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
              filterResponse.text,
              style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
            )
          ],
        ),
      ),
    );
  }
}
