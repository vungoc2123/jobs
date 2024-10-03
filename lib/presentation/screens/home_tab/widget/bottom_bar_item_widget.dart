import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/screens/home_tab/home_tab.dart';

class BottomBarItemWidget extends StatelessWidget {
  final bool isSelected;
  final HomePageModel item;

  const BottomBarItemWidget({
    super.key,
    required this.isSelected,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        SvgPicture.asset(item.iconUrl,
            width: 20.r,
            height: 20.r,
            colorFilter: ColorFilter.mode(
                isSelected ? AppColors.blueF8 : AppColors.grey72,
                BlendMode.srcIn)),
        SizedBox(
          height: 5.h,
        ),
        Text(
          item.name,
          style: AppTextStyle.textXs.copyWith(
              color: isSelected ? AppColors.blueF8 : AppColors.grey72),
        )
      ],
    );
  }
}
