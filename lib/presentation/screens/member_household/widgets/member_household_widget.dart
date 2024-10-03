import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';

class MemberHouseholdWidget extends StatelessWidget {
  final MemberHouseholdResponse member;

  const MemberHouseholdWidget({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteName.detailMemberHousehold, arguments: member.id);
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.greyF6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  member.fullName ?? tr("noInfo"),
                  style: AppTextStyle.textSm.copyWith(
                      color: AppColors.grey26, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
                Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000.r),
                      color: AppColors.greyF6),
                  child:
                      Assets.icons.icArrowRight.svg(width: 16.r, height: 16.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfo(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey86, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Text(
            (value == null || value == "") ? tr("noInfo") : value,
            style: AppTextStyle.textSm
                .copyWith(color: AppColors.grey26, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
