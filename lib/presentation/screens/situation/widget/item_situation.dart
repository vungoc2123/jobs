import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/service/business_service.dart';

class ItemSituation extends StatelessWidget {
  const ItemSituation({super.key, required this.business});

  final BusinessServiceResponse business;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Column(
        children: [
          itemRow(title: "Tên doanh nghiệp: ", content: business.nameBusiness),
          const Divider(
            color: AppColors.greyFB,
          ),
          itemRow(title: "Mã số thuế: ", content: business.taxCode),
          const Divider(
            color: AppColors.greyFB,
          ),
          itemRow(title: "Địa chỉ: ", content: business.address),
        ],
      ),
    );
  }

  Widget itemRow({required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTextStyle.textSm.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        )),
        Expanded(
            child: Text(
          content,
          style: AppTextStyle.textSm
              .copyWith(fontWeight: FontWeight.w400, color: AppColors.textPrimary),
          textAlign: TextAlign.justify,
        ))
      ],
    );
  }
}
