import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/advise/advise_response.dart';

class ItemAdvise extends StatelessWidget {
  const ItemAdvise({super.key, required this.advise});

  final AdviseResponse advise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Column(
        children: [
          rowItem(title: "Tên doanh nghiệp: ", content: advise.nameBusiness),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(title: "Mã số thuế: ", content: advise.taxCode),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(title: "Hotline: ", content: advise.hotline),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(title: "Địa chỉ: ", content: advise.address),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(
              title: "Tên Khu công nghiệp: ",
              content: advise.nameIndustrialPark)
        ],
      ),
    );
  }

  Widget rowItem({required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTextStyle.textSm.copyWith(
              fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        )),
        Expanded(
            child: Text(
          content.isEmpty ? 'Chưa biết' : content,
          style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.left,
        ))
      ],
    );
  }
}
