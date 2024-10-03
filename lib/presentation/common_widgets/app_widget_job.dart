import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class AppWidgetJob extends StatelessWidget {
  const AppWidgetJob(
      {super.key,
      required this.job,
      this.onEdit,
      this.onDelete,
      required this.typeAction});

  final JobResponse job;
  final TypeAction typeAction;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          border:
              Border.all(color: AppColors.blue.withOpacity(0.5), width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.dateStart.formatToDMY(),
                style: AppTextStyle.textXs.copyWith(color: AppColors.grey73),
              ),
              if (typeAction == TypeAction.manage)
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 20.r,
                    height: 24.r,
                    child: PopupMenuButton(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: onEdit,
                                child: Text(
                                  tr("edit"),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.textSm,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: onDelete,
                                child: Text(
                                  tr("delete"),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.textSm,
                                ),
                              )
                            ]),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            width: 1.sw - 32.w,
            alignment: Alignment.centerLeft,
            child: Text(
              "${job.title.isNotEmpty ? job.title : tr('noInfo')}\n",
              style:
                  AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.greyF6)),
                child: AppNetworkImage(
                  job.getImagePath(),
                  radius: 8.r,
                  height: 100.r,
                  width: 100.r,
                  fit: BoxFit.contain,
                  isShowBorder: false,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: SizedBox(
                  height: 100.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${job.businessName.isNotEmpty ? job.businessName : tr('noInfo')}\n",
                        style: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Row(
                        children: [
                          Assets.icons.markerPin03.svg(
                              height: 16.r,
                              width: 16.r,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.greyAE, BlendMode.srcIn)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Expanded(
                            child: Text(
                                job.nameProvince.isNotEmpty
                                    ? job.nameProvince
                                    : tr('noInfo'),
                                style: AppTextStyle.textSm.copyWith(
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis)),
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      Row(
                        children: [
                          Assets.icons.bankNote03.svg(
                              height: 16.r,
                              width: 16.r,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.greyAE, BlendMode.srcIn)),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                              job.salary.isNotEmpty ? job.salary : tr('noInfo'),
                              style: AppTextStyle.textSm.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.green50))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
