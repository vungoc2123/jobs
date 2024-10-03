import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationResponse not;

  const NotificationWidget({super.key, required this.not});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 4.w,),
        SizedBox(
          width: 1.sw - 32.w,
          child: Row(
            children: [
              Image.asset(
                Assets.images.imgLogoApp.path,
                width: 60.r,
                height: 60.r,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkIsHtml(not.message)
                        ? Html(
                            data: not.message,
                            style: {
                              "p": Style(
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.large,
                                  color: AppColors.grey26)
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Text(
                              not.message ?? tr("noTitle"),
                              style: AppTextStyle.textSm.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey26),
                            ),
                          ),
                    if (not.createdDate != null)
                      Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(not.createdDate!.formatToHSDMY(),style: AppTextStyle.textSm.copyWith(color: AppColors.grey86),))
                  ],
                ),
              )
            ],
          ),
        ),
        if (not.isRead != true)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.r),
            child: Container(
              width: 12.r,
              height: 12.r,
              decoration: BoxDecoration(
                  color: AppColors.blueEA,
                  borderRadius: BorderRadius.circular(99.r)),
            ),
          )
      ],
    );
  }

  bool checkIsHtml(String? message) {
    if (message != null && message.isNotEmpty && message[0] == '<') return true;
    return false;
  }
}
