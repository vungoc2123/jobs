import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';

class JobInfoWidget extends StatelessWidget {
  const JobInfoWidget({super.key, required this.jobResponse});

  final JobResponse jobResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rowItem(
            title: 'Ngày đăng tuyển',
            desc: jobResponse.dateStart.formatToDMY()),
        const Divider(
          color: AppColors.whiteD6,
        ),
        rowItem(
            title: 'Số lương tuyển',
            desc: jobResponse.numberOfVacancies.toString()),
        const Divider(
          color: AppColors.whiteD6,
        ),
        rowItem(title: 'Loại hình', desc: jobResponse.natureOfWork),
        const Divider(
          color: AppColors.whiteD6,
        ),
        rowItem(title: 'Cấp bậc', desc: jobResponse.jobPosition),
        const Divider(
          color: AppColors.whiteD6,
        ),
        rowItem(title: 'Ngành nghề', desc: jobResponse.recruitmentIndustry),
        const Divider(
          color: AppColors.whiteD6,
        ),
        rowItem(
            title: 'Trình độ',
            desc: jobResponse.professionalQualificationsRequired),
      ],
    );
  }

  Widget rowItem({required String title, required String desc}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(title,
              style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w400)),
        ),
        Expanded(
          child: Text(
            desc.isNotEmpty ? desc : tr('noInfo'),
            style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
