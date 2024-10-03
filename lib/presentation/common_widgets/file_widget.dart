import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/utils/app_utils.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class FileWidget extends StatelessWidget {
  final String urlFile;

  const FileWidget({super.key, required this.urlFile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: () {
        AppUtils.downloadFile(urlFile, context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 4.r, right: 12.r, left: 4.r, bottom: 4.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.blueFF)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1.sw - 100.w,
              child: Row(
                children: [
                  Assets.icons.icFile.svg(
                      colorFilter: const ColorFilter.mode(
                          AppColors.blueFF, BlendMode.srcIn)),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    getNameFile(urlFile).length > 20
                        ? "${getNameFile(urlFile).substring(0, 30)}..."
                        : getNameFile(urlFile),
                    style: AppTextStyle.textXs.copyWith(
                        fontWeight: FontWeight.w600, color: AppColors.grey73),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              "Mở",
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.orange),
            ),
          ],
        ),
      ),
    );
  }

  String getNameFile(String url) {
    return url.split('\\').last;
  }
}
