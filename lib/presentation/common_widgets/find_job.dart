import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

import '../../application/constants/app_color.dart';
import '../../gen/assets.gen.dart';

class FindJob extends StatelessWidget {
  const FindJob({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.icons.heart.svg(
            width: 50.w,
            height: 50.w,
            colorFilter:
            const ColorFilter.mode(AppColors.greyE5, BlendMode.srcIn)),
        Text(title, style: AppTextStyle.textLg,),

        GestureDetector(
          child: Text(tr("find_job_now"),style: AppTextStyle.textLg.copyWith(color: AppColors.blueF8),),
        )

      ],
    );
  }
}
