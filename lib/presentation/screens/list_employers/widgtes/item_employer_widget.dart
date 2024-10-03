import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class ItemEmployerWidget extends StatelessWidget {
  final Employer item;

  const ItemEmployerWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 1.r,
            color: AppColors.greyE5,
          )),
      width: 1.sw / 3 + 90.w,
      child: Column(
        children: [
          SizedBox(
            height: 150.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0,
                    child: AppNetworkImage(
                      item.images.split(';')[0],
                      fit: BoxFit.cover,
                      height: 120.h,
                      width: 1.sw / 3 * 2,
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.sp, color: AppColors.greyE5),
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white),
                    width: 70.r,
                    height: 70.r,
                    child: AppNetworkImage(item.avatar),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              children: [
                Text(
                  item.nameEmployer,
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  item.field,
                  style: AppTextStyle.textXs.copyWith(
                    color: AppColors.grey73,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "${item.numberFollow} ${tr("numberFollow")}",
                  style: AppTextStyle.textXs,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "${item.numberJobs} việc làm",
                  style: AppTextStyle.textXs,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppButton(
                  title: tr("follow"),
                  color: Colors.white,
                  height: 40.h,
                  borderColor: Colors.orange,
                  radius: 8.r,
                  textStyle: AppTextStyle.textSm.copyWith(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Employer {
  final String nameEmployer;
  final int numberFollow;
  final int numberJobs;
  final String field;
  final String avatar;
  final String headQuarters;
  final String scale;
  final String introduce;
  final String images;
  final List<String> welfare;

  const Employer(
      {required this.nameEmployer,
      required this.numberFollow,
      required this.numberJobs,
      required this.field,
      required this.avatar,
      required this.headQuarters,
      required this.scale,
      required this.introduce,
      required this.images,
      required this.welfare});
}
