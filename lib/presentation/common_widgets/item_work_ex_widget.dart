import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';
import 'package:phu_tho_mobile/presentation/screens/home/widget/profile_widget.dart';

class ItemWorkExWidget extends StatelessWidget {
  final Experience experience;
  const ItemWorkExWidget({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r)),
            child: AppNetworkImage(
              experience.imageCompany,
              radius: 8.r,
              height: 100.r,
              width: 100.r,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(experience.position,
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w600)),
                Text(experience.company,
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w500)),
                Text(experience.experience,
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w500)),
                Text(experience.address,
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
