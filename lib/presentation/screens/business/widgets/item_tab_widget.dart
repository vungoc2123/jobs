import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class ItemTabWidget extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback onPressed;

  const ItemTabWidget(
      {super.key,
      required this.label,
      this.value = '',
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        onPressed.call();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: value != "" ? AppColors.blueF8 : AppColors.greyDF),
            color: Colors.white),
        child: Text(
          value == ""
              ? label
              : (value.length > 15 ? "${value.substring(0, 15)}..." : value),
          style: AppTextStyle.textSm
              .copyWith(fontWeight: FontWeight.w400, color: AppColors.grey52),
          maxLines: 1,
        ),
      ),
    );
  }
}
