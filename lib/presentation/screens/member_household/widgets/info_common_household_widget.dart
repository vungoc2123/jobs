import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/row_infomation_widget.dart';

class InfoCommonHouseholdWidget extends StatelessWidget {
  final HouseholdResponse household;

  const InfoCommonHouseholdWidget({super.key, required this.household});

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
          RowInformationWidget(
              label: "Tên chủ hộ", value: household.fullNameOfHouseholdHead),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(
              label: "Số hộ khẩu", value: household.householdRegistrationBook),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(label: "Khu vực", value: household.area),
          Divider(
            color: AppColors.greyF6,
            height: 20.h,
          ),
          RowInformationWidget(
              label: "Địa chỉ",
              value:
                  "${household.detailAddress}, ${household.communeName}, ${household.districtName}, ${household.provinceName} "),
        ],
      ),
    );
  }
}
