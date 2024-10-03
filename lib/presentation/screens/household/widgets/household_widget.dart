import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';

class HouseholdItemWidget extends StatelessWidget {
  final HouseholdResponse household;

  const HouseholdItemWidget({super.key, required this.household});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.greyF6)),
      child: Column(
        children: [
          rowInfo("Tên chủ hộ:", household.fullNameOfHouseholdHead),
          SizedBox(
            height: 8.h,
          ),
          rowInfo("Số hộ khẩu:", household.householdRegistrationBook),
          SizedBox(
            height: 8.h,
          ),
          rowInfo("Số CCCD:", household.idNumberOfHouseholdHead),
          SizedBox(
            height: 8.h,
          ),
          rowInfo("Khu vực:", household.area),
          SizedBox(
            height: 8.h,
          ),
          rowInfo("Địa chỉ:",
              "${household.detailAddress}, ${household.communeName}, ${household.districtName}, ${household.provinceName} "),
        ],
      ),
    );
  }

  Widget rowInfo(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey52, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
            child: Text((value == null || value == "") ? tr("noInfo") : value,
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.grey52, fontWeight: FontWeight.w400)))
      ],
    );
  }
}
