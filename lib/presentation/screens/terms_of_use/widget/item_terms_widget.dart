import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/terms_of_use/terms_of_use_response.dart';

class ItemTermsWidget extends StatelessWidget {
  const ItemTermsWidget({super.key, required this.terms});

  final TermsOfUseResponse terms;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          terms.name,
          style: AppTextStyle.textSm.copyWith(
              fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
          children: [
            Text(
              "${tr("description")}: ",
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textPrimary),
            ),
            Text(
              terms.description ?? tr("no"),
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textPrimary),
            )
          ],
        )
      ],
    );
  }
}
