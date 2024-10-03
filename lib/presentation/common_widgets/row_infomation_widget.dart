import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';

class RowInformationWidget extends StatelessWidget {
  final String label;
  final String? value;

  const RowInformationWidget({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.grey86, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Text(
            (value == null || value == "") ? tr("noInfo") : value!,
            style: AppTextStyle.textSm
                .copyWith(color: AppColors.grey26, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
