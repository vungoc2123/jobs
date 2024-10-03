import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/application/constants/app_text_style.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_network_image.dart';

class NewsItemWidget extends StatelessWidget {
  const NewsItemWidget(
      {super.key, required this.news, this.isShowDate = false});

  final NewsResponse news;
  final bool isShowDate;

  String  getDate(){
    if(news.dateShow.isEmpty){
      return "Chưa biết";
    }

    if(news.dateExpiration.isEmpty){
      return news.dateShow;
    }

    return "${news.dateShow} - ${news.dateExpiration}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(
          width: (1.sw-32.w)/3.5,
          height: (1.sw-70.w)/3.5,
          news.getAvatar(),
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                news.title,
                style:
                    AppTextStyle.textSm.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 8.h,),

              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Assets.icons.icCalendar.svg(
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary, BlendMode.srcIn),
                      ),
                    ),
                    WidgetSpan(child: SizedBox(width: 8.w,)),
                    TextSpan(
                      text:
                          getDate(),
                      style: AppTextStyle.textXs.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary),
                    ),
                  ],
                ),
                maxLines: 1,
              )
            ],
          ),
        )
      ],
    );
  }
}
