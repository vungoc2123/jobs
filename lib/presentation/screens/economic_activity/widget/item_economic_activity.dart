import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';

class ItemEconomicActivity extends StatelessWidget {
  const ItemEconomicActivity({super.key, required this.economicActivity});

  final EconomicActivityResponse economicActivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyEF),
          color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          info("Tên", economicActivity.namePerson),
          SizedBox(
            height: 8.h,
          ),
          info("Nơi làm việc", economicActivity.location),
          SizedBox(
            height: 8.h,
          ),
          info("Vị trí công việc", economicActivity.position),
          SizedBox(
            height: 8.h,
          ),
          info(
              "Tự làm/làm công",
              economicActivity.selfEmployedAndEmployed.isNotEmpty
                  ? economicActivity.selfEmployedAndEmployed
                  : "Chưa có thông tin"),
          SizedBox(
            height: 8.h,
          ),
          info(
              "Mô tả",
              economicActivity.description.isNotEmpty
                  ? economicActivity.description
                  : "Chưa có thông tin"),
          SizedBox(
            height: 8.h,
          ),
          info("Loại hình kinh tế", economicActivity.typeEconomic),
          SizedBox(
            height: 8.h,
          ),
          info("Thời gian bắt đầu", economicActivity.timeStart),
          SizedBox(
            height: 8.h,
          ),
          info("Thời gian kết thúc", economicActivity.timeEnd),
        ],
      ),
    );
  }

  Widget info(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$title: ",
            style: AppTextStyle.textSm
                .copyWith(color: AppColors.grey86, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            textAlign: TextAlign.right,
            content,
            style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
