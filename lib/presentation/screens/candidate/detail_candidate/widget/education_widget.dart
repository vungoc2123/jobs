import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/profile_widget.dart';

class EducationWidget extends StatelessWidget {
  final ProfileModel profile;
  const EducationWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: AppColors.whiteFF,
      child: Column(
        children: [
          line(Assets.icons.school.path, "${tr('school')}:",
              profile.school),
          line(Assets.icons.productsMajor.path, "${tr('specialized')}:",
              profile.specialized),
        ],
      ),
    );
  }

  Widget line(String icon, String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(icon,
                width: 20.r,
                height: 20.r,
                colorFilter:
                    const ColorFilter.mode(AppColors.blue, BlendMode.srcIn)),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Text(
              content,
              style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
