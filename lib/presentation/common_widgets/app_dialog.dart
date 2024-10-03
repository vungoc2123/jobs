import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_button.dart';

class AppDialog {
  static show(BuildContext context, {required Widget child, Color? color, bool barrierDismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        backgroundColor: color ?? AppColors.white,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        content: child,
      ),
    );
  }

  static showDialogConfirm(
    BuildContext context, {
    required String label,
    bool barrierDismissible = true,
    required VoidCallback onConfirm,
  }) {
    return AppDialog.show(
      context,
      barrierDismissible: barrierDismissible,
      child: PopScope(
        canPop: barrierDismissible,
        child: Container(
          padding: EdgeInsets.only(top: 32.r, bottom: 16.r, right: 20.r, left: 20.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
                  color: AppColors.blueF8,
                  child: Assets.icons.icAttention.svg(),
                ),
              ),
              SizedBox(height: 24.r),
              Text(
                label,
                style: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.r),
              Row(
                children: [
                  if (barrierDismissible) ...[
                    Flexible(
                      flex: 1,
                      child: AppButton(
                        onPressed: () => Navigator.of(context).pop(),
                        title: 'Hủy bỏ',
                        color: Colors.white,
                        borderColor: AppColors.grey52,
                        radius: 8.r,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        textStyle: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w700, color: AppColors.grey52),
                      ),
                    ),
                    SizedBox(width: 12.r),
                  ],
                  Flexible(
                    flex: 1,
                    child: AppButton(
                      onPressed: () => onConfirm.call(),
                      title: 'Đồng ý',
                      color: AppColors.blueF8,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      radius: 8.r,
                      textStyle: AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w700, color: AppColors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
