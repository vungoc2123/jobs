import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class ItemMenuHome extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool visible;
  final VoidCallback onPressed;

  const ItemMenuHome(
      {super.key,
      required this.label,
      required this.iconPath,
      required this.visible,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        onPressed.call();
      },
      child: Container(
        padding: EdgeInsets.all(4.r),
        width: (1.sw - 60.w) / 3,
        decoration: BoxDecoration(
            // color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.greyFB,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 32.r,
                height: 32.r,
                colorFilter: const ColorFilter.mode(
                  AppColors.blueEA,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: (1.sw - 140.w) / 3,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style:
                    AppTextStyle.textXs.copyWith(fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
