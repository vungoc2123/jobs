import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/item_work_ex_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/profile_widget.dart';

class ExperienceWidget extends StatelessWidget {
  final ProfileModel profile;

  const ExperienceWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewPadding(
      context: context,
      removeBottom: true,
      child: Container(
          color: AppColors.whiteFF,
          padding: EdgeInsets.all(16.r),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              height: 32.h,
            ),
            itemCount: profile.experiences.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemWorkExWidget(
                experience: profile.experiences[index],
              );
            },
          )),
    );
  }
}
