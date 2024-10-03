import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/int_extension.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/emty_list_data.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/widget/gradian_appbar.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/widget/item_situation.dart';

import '../../../../application/constants/app_color.dart';
import '../../../../domain/models/response/service/business_service.dart';

class DetailSituation extends StatelessWidget {
  const DetailSituation({super.key, required this.business});

  final BusinessServiceResponse business;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: GradientAppBar(
          title: Text(
            "Thông tin nộp phí dịch vụ",
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
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thông tin công ty",
                    style: AppTextStyle.textBase.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.w)),
                      child: ItemSituation(business: business))
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Các khoản phí dịch vụ",
                style: AppTextStyle.textBase.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              SizedBox(
                height: 8.h,
              ),
              (business.listServiceFee != null &&
                      business.listServiceFee!.isNotEmpty)
                  ? ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: business.listServiceFee?.length ?? 0,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.w)),
                        child: Column(
                          children: [
                            itemRow(
                                title: "Người nộp: ",
                                content: business.listServiceFee?[index].name ??
                                    "chưa biết"),
                            SizedBox(
                              height: 4.h,
                            ),
                            itemRow(
                                title: "Tên dịch vụ: ",
                                content: business
                                        .listServiceFee?[index].nameService ??
                                    "chưa biết"),
                            SizedBox(
                              height: 4.h,
                            ),
                            itemRow(
                                title: "Số tiền: ",
                                content: business.listServiceFee?[index].cost
                                        .toInt()
                                        .formatCurrency() ??
                                    "0 VND"),
                            SizedBox(
                              height: 4.h,
                            ),
                            itemRow(
                                title: "Người nộp: ",
                                content: business.listServiceFee?[index].note ??
                                    "chưa biết"),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                    )
                  : const Center(
                      child: EmptyListData(),
                    )
            ],
          ),
        ),
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
          style: AppTextStyle.textSm.copyWith(
              fontWeight: FontWeight.w400, color: AppColors.textPrimary),
          textAlign: TextAlign.justify,
        ))
      ],
    );
  }
}
