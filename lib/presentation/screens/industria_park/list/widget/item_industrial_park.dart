import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';

class ItemIndustrialPark extends StatelessWidget {
  const ItemIndustrialPark(
      {super.key,
      required this.industrialPark,
      this.onPressDelete,
      this.onPressUpdate});

  final IndustrialParkResponse industrialPark;
  final VoidCallback? onPressDelete;
  final VoidCallback? onPressUpdate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.detailIndustrialPark,
            arguments: industrialPark);
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.greyEF),
        ),
        padding: EdgeInsets.all(8.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  industrialPark.name,
                  style: AppTextStyle.textBase
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (onPressDelete != null && onPressUpdate != null)
                  PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: onPressUpdate,
                              child: Text(
                                tr("edit"),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.textSm,
                              ),
                            ),
                            PopupMenuItem(
                              onTap: onPressDelete,
                              child: Text(
                                tr("delete"),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.textSm,
                              ),
                            )
                          ])
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      itemInfo(
                          icon: Assets.icons.markerPin03.path,
                          title: tr('locationIndustrialPark'),
                          color: AppColors.grey52,
                          content: industrialPark.location),
                      SizedBox(
                        height: 6.h,
                      ),
                      itemInfo(
                          icon: Assets.icons.markerPin03.path,
                          title: tr('nameCommune'),
                          color: AppColors.grey52,
                          content: industrialPark.nameCommune),
                      SizedBox(
                        height: 6.h,
                      ),
                      itemInfo(
                          icon: Assets.icons.locationArrow.path,
                          title: tr('nameDistrict'),
                          color: AppColors.grey52,
                          content: industrialPark.nameDistrict),
                      SizedBox(
                        height: 6.h,
                      ),
                      itemInfo(
                          icon: Assets.icons.operation.path,
                          title: tr('status'),
                          content: industrialPark.status,
                          color: AppColors.green50),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemInfo(
      {required String icon,
      required String title,
      required String content,
      Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.h),
          child: SvgPicture.asset(icon,
              height: 16.r,
              width: 16.r,
              colorFilter:
                  const ColorFilter.mode(AppColors.grey52, BlendMode.srcIn)),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Text(
              '$title: ${content.isNotEmpty ? content : "Chưa có thông tin"}',
              style: AppTextStyle.textSm
                  .copyWith(fontWeight: FontWeight.w400, color: color)),
        ),
      ],
    );
  }
}
