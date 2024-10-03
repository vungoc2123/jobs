import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class ItemSupportWidget extends StatelessWidget {
  final Support item;

  const ItemSupportWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color:AppColors.greyE5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.icon,
          SizedBox(height: 4.h,),
          Text(item.name,style: AppTextStyle.textXs,)
        ],
      ),
    );
  }
}

class Support {
  final Widget icon;
  final String name;

  const Support({required this.icon, required this.name});
}
