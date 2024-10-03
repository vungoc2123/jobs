import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/constants/app_color.dart';
import '../../application/constants/app_text_style.dart';
import '../../gen/assets.gen.dart';

class EmptyListData extends StatelessWidget {
  const EmptyListData({super.key, this.title, this.icon});

  final String? title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? Image.asset(
          Assets.images.folder.path,
          width: 1.sw / 3,
        ),
        SizedBox(
          height: 35.h,
        ),
        Text(
          title ?? tr("noData"),
          style: AppTextStyle.textSm.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
