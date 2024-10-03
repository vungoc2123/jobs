import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';

class ItemTradingJob extends StatelessWidget {
  const ItemTradingJob({super.key, required this.tradingJob});

  final TradingJobResponse tradingJob;

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
          Text(
            tradingJob.name,
            style: AppTextStyle.textBase.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          info("Mã phiên", tradingJob.code),
          SizedBox(
            height: 8.h,
          ),
          info("Mô tả", tradingJob.description),
          SizedBox(
            height: 8.h,
          ),
          info("Số điện thoại", tradingJob.hotline),
          SizedBox(
            height: 8.h,
          ),
          info("Địa điểm", tradingJob.location),
          SizedBox(
            height: 8.h,
          ),
          info("Thời gian bắt đầu", tradingJob.timeStart.formatToHSDMY()),
          SizedBox(
            height: 8.h,
          ),
          info("Thời gian kết thúc", tradingJob.timeEnd.formatToHSDMY()),
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
