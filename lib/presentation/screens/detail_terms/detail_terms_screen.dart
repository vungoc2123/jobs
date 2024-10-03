import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/file_widget.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';

import '../../../domain/models/response/terms_of_use/terms_of_use_response.dart';

class DetailTermsScreen extends StatelessWidget {
  const DetailTermsScreen({super.key, required this.terms});

  final TermsOfUseResponse terms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Text(
            "Chi tiết tài liệu",
            style: AppTextStyle.textLg
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          isOpenSearch: false,
          gradient: const LinearGradient(
              colors: [AppColors.blue44, AppColors.blueF8],
              begin: Alignment.topLeft,
              end: Alignment.topRight)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                terms.name,
                style: AppTextStyle.textBase.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Text(
                    "Mô tả: ",
                    style: AppTextStyle.textSm.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary),
                  ),
                  Text(
                    terms.description ?? "Không có",
                    style: AppTextStyle.textSm.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Tài liệu đính kèm: ",
                style: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              SizedBox(
                height: 4.h,
              ),
              terms.file == "Không có file đính kèm"
                  ? Text(
                      terms.file,
                      style: AppTextStyle.textSm
                          .copyWith(color: AppColors.textPrimary),
                    )
                  : FileWidget(urlFile: AppUtils.getPath(terms.file) ?? "")
            ],
          ),
        ),
      ),
    );
  }
}
